#' Plot QQ plot
#'
#' Plot quantile-quantile for each continuous feature
#' @param data input data
#' @param by feature name to be broken down by. If selecting a continuous feature, it will be grouped by 5 equal ranges, otherwise, all existing categories for a discrete feature. Default is \code{NULL}.
#' @param sampled_rows number of rows to sample if data has too many rows. Default is all rows, which means do not sample.
#' @param geom_qq_args a list of other arguments to \link{geom_qq}
#' @param geom_qq_line_args a list of other arguments to \link{geom_qq_line}
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. Default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}
#' @param nrow number of rows per page. Default is 3.
#' @param ncol number of columns per page. Default is 3.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_qq
#' @import data.table
#' @import ggplot2
#' @importFrom parallel mclapply
#' @export
#' @examples
#' plot_qq(iris)
#' plot_qq(iris, by = "Sepal.Width")
#' plot_qq(iris, by = "Species", nrow = 2L, ncol = 2L)
#'
#' plot_qq(
#'   data = airquality,
#'   geom_qq_args = list(na.rm = TRUE),
#'   geom_qq_line_args = list(na.rm = TRUE)
#' )

plot_qq <- function(data, by = NULL, sampled_rows = nrow(data), geom_qq_args = list(), geom_qq_line_args = list(), title = NULL, ggtheme = theme_gray(), theme_config = list(), nrow = 3L, ncol = 3L) {
	## Declare variable first to pass R CMD check
	variable <- value <- group <- NULL
	## Check if input is data.table
	if (!is.data.table(data)) data <- data.table(data)
	## Sample data if necessary
	if (sampled_rows < nrow(data)) data <- data[sample.int(nrow(data), sampled_rows)]
	## Stop if no continuous features
	split_obj <- split_columns(data)
	if (split_obj$num_continuous == 0) stop("No Continuous Features!")
	## Get continuous features
	continuous <- split_obj$continuous
	## Check feature to be broken down
	if (!is.null(by)) {
		by_feature <- data[[by]]
		if (is.null(by_feature)) stop(paste0("Feature \"", by, "\" not found!"))
		if (is.numeric(by_feature)) {
			dt <- suppressWarnings(melt.data.table(data.table(continuous, "group" = cut_interval(by_feature, 5)), id.vars = "group", variable.factor = FALSE))
		} else {
			dt <- suppressWarnings(melt.data.table(data.table(continuous, "group" = by_feature), id.vars = "group", variable.factor = FALSE))
		}
		dt2 <- dt[variable != by]
	} else {
		dt2 <- suppressWarnings(melt.data.table(data.table(continuous), measure.vars = names(continuous), variable.factor = FALSE))
	}
	feature_names <- unique(dt2[["variable"]])
	## Calculate number of pages
	layout <- .getPageLayout(nrow, ncol, ncol(continuous))
	## Create list of ggplot objects
	plot_list <- mclapply(
		layout,
		function(x) {
			if (is.null(by)) {
				ggplot(dt2[variable %in% feature_names[x]], aes(sample = value)) +
					do.call("geom_qq", geom_qq_args) +
					do.call("geom_qq_line", geom_qq_line_args)
			} else {
				ggplot(dt2[variable %in% feature_names[x]], aes(sample = value, color = group)) +
					do.call("geom_qq", geom_qq_args) +
					do.call("geom_qq_line", geom_qq_line_args)
			}
		},
		mc.preschedule = TRUE,
		mc.silent = TRUE,
		mc.cores = .getCores()
	)
	## Plot objects
	class(plot_list) <- c("multiple", class(plot_list))
	plotDataExplorer(
		plot_obj = plot_list,
		page_layout = layout,
		title = title,
		ggtheme = ggtheme,
		theme_config = theme_config,
		facet_wrap_args = list(
			"facet" = ~ variable,
			"nrow" = nrow,
			"ncol" = ncol,
			"scales" = "free_y"
		)
	)
}
