#' Plot histogram
#'
#' Plot histogram for each continuous feature
#' @param data input data
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page. Default is 4.
#' @param ncol number of columns per page. Default is 4.
#' @param \dots other arguments to be passed to \link{geom_histogram}.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_histogram
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @import data.table
#' @import ggplot2
#' @import gridExtra
#' @importFrom stats na.omit
#' @importFrom parallel mclapply
#' @importFrom parallel detectCores
#' @export plot_histogram
#' @seealso \link{geom_histogram} \link{plot_density}
#' @examples
#' # Plot iris data
#' plot_histogram(iris)
#'
#' # Plot random data with customized geom_histogram settings
#' set.seed(1)
#' data <- cbind(sapply(seq.int(4L), function(x) {rnorm(1000, sd = 30 * x)}))
#' plot_histogram(data, breaks = seq(-400, 400, length = 50))
#'
#' # Plot histogram with preset ggplot2 themes
#' library(ggplot2)
#' plot_histogram(data, ggtheme = theme_light())
#' plot_histogram(data, ggtheme = theme_minimal(base_size = 15))
#'
#' # Plot histogram with customized theme components
#' plot_histogram(data,
#' theme_config = list(
#'   "plot.background" = element_rect(fill = "yellow"),
#'   "aspect.ratio" = 1
#' ))

plot_histogram <- function(data, title = NULL, ggtheme = theme_gray(), theme_config = list(), nrow = 4L, ncol = 4L, ...) {
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
				geom_histogram(bins = 30L, ...) +
				ylab("Frequency") +
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
