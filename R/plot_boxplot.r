#' Create boxplot for continuous features
#'
#' This function creates boxplot for each continuous feature based on a selected feature.
#' @param data input data
#' @param by feature name to be broken down by. If selecting a continuous feature, boxplot will be grouped by 5 equal ranges, otherwise, all existing categories for a discrete feature.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page
#' @param ncol number of columns per page
#' @param \dots other arguments to be passed to \link{geom_boxplot}.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_boxplot
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @import data.table
#' @import ggplot2
#' @importFrom parallel mclapply
#' @export plot_boxplot
#' @seealso \link{geom_boxplot}
#' @examples
#' # Plot iris dataset by "Species" (discrete)
#' plot_boxplot(iris, by = "Species", nrow = 2L, ncol = 2L)
#'
#' # Plot iris dataset by "Sepal.Length" (continuous)
#' plot_boxplot(iris, by = "Sepal.Length", nrow = 2L, ncol = 2L)
#'
#' # Plot with preset ggplot2 themes
#' library(ggplot2)
#' plot_boxplot(iris, by = "Species", ggtheme = theme_light())
#' plot_boxplot(iris, by = "Species", ggtheme = theme_minimal(base_size = 20))

plot_boxplot <- function(data, by, title = NULL, ggtheme = theme_gray(), theme_config = list(), nrow = 3L, ncol = 4L, ...) {
	## Declare variable first to pass R CMD check
	variable <- by_f <- value <- NULL
	## Check if input is data.table
	if (!is.data.table(data)) data <- data.table(data)
	## Stop if no continuous features
	split_obj <- split_columns(data)
	if (split_obj$num_continuous == 0) stop("No Continuous Features!")
	## Get continuous features
	continuous <- split_obj$continuous
	## Check feature to be broken down
	by_feature <- data[[by]]
	if (is.null(by_feature)) stop(paste0("Feature \"", by, "\" not found!"))
	if (is.numeric(by_feature)) {
		dt <- suppressWarnings(melt.data.table(data.table(continuous, "by_f" = cut_interval(by_feature, 5)), id.vars = "by_f", variable.factor = FALSE))
	} else {
		dt <- suppressWarnings(melt.data.table(data.table(continuous, "by_f" = by_feature), id.vars = "by_f", variable.factor = FALSE))
	}
	dt2 <- dt[variable != by]
	feature_names <- unique(dt2[["variable"]])
	## Calculate number of pages
	layout <- .getPageLayout(nrow, ncol, length(feature_names))
	## Create list of ggplot objects
	plot_list <- mclapply(
		layout,
		function(x) {
			ggplot(dt2[variable %in% feature_names[x]], aes(x = by_f, y = value)) +
				geom_boxplot(...) +
				coord_flip() +
				xlab(by)
		},
		mc.preschedule = TRUE,
		mc.silent = TRUE,
		mc.cores = .getCores()
	)
	## Plot objects
	class(plot_list) <- c("multiple", class(plot_list))
	plotDataExplorer(
		obj_list = plot_list,
		page_layout = layout,
		title = title,
		ggtheme = ggtheme,
		theme_config = theme_config,
		facet = ~ variable,
		nrow = nrow,
		ncol = ncol,
		scales = "free_x"
	)
}
