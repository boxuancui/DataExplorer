#' Plot histogram
#'
#' Plot histogram for each continuous feature
#' @param data input data
#' @param geom_histogram_args a list of other arguments to \link{geom_histogram}
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page. Default is 4.
#' @param ncol number of columns per page. Default is 4.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_histogram
#' @import data.table
#' @import ggplot2
#' @importFrom stats setNames
#' @importFrom parallel mclapply
#' @export
#' @seealso \link{geom_histogram} \link{plot_density}
#' @examples
#' # Plot iris data
#' plot_histogram(iris)
#'
#' # Plot random data with customized geom_histogram settings
#' set.seed(1)
#' data <- cbind(sapply(seq.int(4L), function(x) {rnorm(1000, sd = 30 * x)}))
#' plot_histogram(data, geom_histogram_args = list("breaks" = seq(-400, 400, length = 50)))

plot_histogram <- function(data, geom_histogram_args = list(), title = NULL, ggtheme = theme_gray(), theme_config = list(), nrow = 4L, ncol = 4L) {
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
			x <- continuous[, j, with = FALSE]
			ggplot(x, aes_string(x = names(x))) +
				do.call("geom_histogram", c("na.rm" = TRUE, geom_histogram_args)) +
				ylab("Frequency")
		},
		mc.preschedule = TRUE,
		mc.silent = TRUE,
		mc.cores = .getCores()
	)
	## Plot objects
	class(plot_list) <- c("grid", class(plot_list))
	plotDataExplorer(
		plot_obj = plot_list,
		page_layout = layout,
		nrow = nrow,
		ncol = ncol,
		title = title,
		ggtheme = ggtheme,
		theme_config = theme_config
	)
}
