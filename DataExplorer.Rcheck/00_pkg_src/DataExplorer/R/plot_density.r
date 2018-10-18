#' Plot density estimates
#'
#' Plot density estimates for each continuous feature
#' @param data input data
#' @param geom_density_args a list of other arguments to \link{geom_density}
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page. Default is 4.
#' @param ncol number of columns per page. Default is 4.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_density
#' @import data.table
#' @import ggplot2
#' @import gridExtra
#' @importFrom stats setNames
#' @importFrom parallel mclapply
#' @export
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
#' plot_density(data, geom_density_args = list("fill" = "black", "alpha" = 0.6))

plot_density <- function(data, geom_density_args = list(), title = NULL, ggtheme = theme_gray(), theme_config = list(), nrow = 4L, ncol = 4L) {
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
				do.call("geom_density", c("na.rm" = TRUE, geom_density_args)) +
				ylab("Density")
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
