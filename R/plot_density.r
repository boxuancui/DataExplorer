#' Plot density estimates
#'
#' Plot density estimates for each continuous feature
#' @param data input data
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page. Default is 4.
#' @param ncol number of columns per page. Default is 4.
#' @param \dots other arguments to be passed to \link{geom_density}.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_density
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @import data.table
#' @import ggplot2
#' @import gridExtra
#' @importFrom stats na.omit
#' @importFrom parallel mclapply
#' @importFrom parallel detectCores
#' @export plot_density
#' @seealso \link{geom_density} \link{plot_histogram}
#' @examples
#' # Plot using iris data
#' plot_density(iris)
#'
#' # Plot using random data
#' set.seed(1)
#' data <- cbind(sapply(seq.int(4L), function(x) {
#'           runif(500, min = sample(100, 1), max = sample(1000, 1))
#'         }))
#' plot_density(data)
#'
#' # Add color to density area
#' plot_density(data, fill = "black", alpha = 0.8)
#'
#' # Plot with preset ggplot2 themes
#' library(ggplot2)
#' plot_density(data, ggtheme = theme_light())
#' plot_density(data, ggtheme = theme_minimal(base_size = 15))
#'
#' # Plot with customized theme components
#' plot_density(data,
#' theme_config = list(
#'   "plot.background" = element_rect(fill = "yellow"),
#'   "aspect.ratio" = 1
#' ))


plot_density <- function(data, title = NULL, ggtheme = theme_gray(), theme_config = list(), nrow = 4L, ncol = 4L, ...) {
	if (!is.data.table(data)) data <- data.table(data)
	## Stop if no continuous features
	if (split_columns(data)$num_continuous == 0) stop("No Continuous Features")
	## Get continuous features
	continuous <- split_columns(data)$continuous
	## Calculate number of pages
	layout <- .getPageLayout(nrow, ncol, ncol(continuous))
	## Create ggplot object
	plot_list <- mclapply(
		setNames(seq_along(continuous), names(continuous)),
		function(j) {
			x <- na.omit(continuous[, j, with = FALSE])
			ggplot(x, aes_string(x = names(x))) +
				geom_density(...) +
				ylab("Density") +
				ggtheme +
				do.call(theme, theme_config)
		},
		mc.preschedule = TRUE,
		mc.silent = TRUE,
		mc.cores = detectCores() - 1L
	)
	## Plot objects
	class(plot_list) <- c(class(plot_list), "DataExplorerGrid")
	plot.DataExplorerGrid(
		obj_list = plot_list,
		page_layout = layout,
		nrow = nrow,
		ncol = ncol,
		title = title,
		ggtheme = ggtheme,
		theme_config = theme_config
	)
}
