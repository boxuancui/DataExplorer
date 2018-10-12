#' Create scatterplot for all features
#'
#' This function creates scatterplot for all features fixing on a selected feature.
#' @param data input data
#' @param by feature name to be fixed at.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page
#' @param ncol number of columns per page
#' @param \dots other arguments to be passed to \link{geom_point}.
#' @keywords plot_scatterplot
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @import data.table
#' @import ggplot2
#' @importFrom parallel mclapply
#' @export plot_scatterplot
#' @seealso \link{geom_point}
#' @examples
#' # Scatterplot iris dataset by "Species"
#' plot_scatterplot(iris, by = "Species")
#'
#' # Customize plot
#' library(ggplot2)
#' plot_scatterplot(
#' 	mpg, "hwy", size = 1,
#' 	theme_config = list("axis.text.x" = element_text(angle = 45, hjust = 1)),
#' 	nrow = 3L, ncol = 4L
#' )
#' plot_scatterplot(
#' 	iris, by = "Species",
#' 	ggtheme = theme_light(), nrow = 2L, ncol = 2L
#' )

plot_scatterplot <- function(data, by, title = NULL, ggtheme = theme_gray(), theme_config = list(), nrow = 3L, ncol = 3L, ...) {
	## Declare variable first to pass R CMD check
	variable <- NULL
	## Check if input is data.table
	if (!is.data.table(data)) data <- data.table(data)
	## Create plot function
	dt <- suppressWarnings(melt.data.table(data, id.vars = by, variable.factor = FALSE))
	feature_names <- unique(dt[["variable"]])
	## Calculate number of pages
	layout <- .getPageLayout(nrow, ncol, length(feature_names))
	## Create list of ggplot objects
	plot_list <- mclapply(
		layout,
		function(x) {
			ggplot(dt[variable %in% feature_names[x]], aes_string(x = by, y = "value")) +
				geom_point(...) +
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
		scales = "free_x",
		shrink = FALSE
	)
}
