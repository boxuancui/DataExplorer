#' Plot bar chart
#'
#' Plot bar chart for each discrete feature, based on either frequency or another continuous feature.
#' @param data input data
#' @param with name of continuous feature to be summed. Default is \code{NULL}, i.e., frequency.
#' @param maxcat maximum categories allowed for each feature. Default is 50.
#' @param order_bar logical, indicating if bars should be ordered. Default is \code{TRUE}.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. Default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}
#' @param nrow number of rows per page. Default is 3.
#' @param ncol number of columns per page. Default is 3.
#' @param parallel enable parallel? Default is \code{FALSE}.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_bar
#' @details If a discrete feature contains more categories than \code{maxcat} specifies, it will not be passed to the plotting function.
#' @import data.table
#' @import ggplot2
#' @importFrom stats reorder
#' @importFrom stats setNames
#' @importFrom tools toTitleCase
#' @export
#' @examples
#' # Load diamonds dataset from ggplot2
#' library(ggplot2)
#' data("diamonds", package = "ggplot2")
#'
#' # Plot bar charts for diamonds dataset
#' plot_bar(diamonds)
#' plot_bar(diamonds, maxcat = 5)
#'
#' # Plot bar charts with `price` feature
#' plot_bar(diamonds, with = "price")

plot_bar <- function(data, with = NULL, maxcat = 50, order_bar = TRUE, title = NULL, ggtheme = theme_gray(), theme_config = list(), nrow = 3L, ncol = 3L, parallel = FALSE) {
	## Declare variable first to pass R CMD check
	frequency <- agg_by <- NULL
	## Check if input is data.table
	if (!is.data.table(data)) data <- data.table(data)
	## Stop if no discrete features
	if (split_columns(data)$num_discrete == 0) stop("No Discrete Features!")
	## Get discrete features
	discrete <- split_columns(data)$discrete
	## Drop features with categories greater than `maxcat`
	ind <- .ignoreCat(discrete, maxcat = maxcat)
	if (length(ind)) {
		message(length(ind), " columns ignored with more than ", maxcat, " categories.\n", paste0(names(ind), ": ", ind, " categories\n"))
		drop_columns(discrete, names(ind))
	}
	## Calculate number of pages
	layout <- .getPageLayout(nrow, ncol, ncol(discrete))
	## Create list of ggplot objects
	plot_list <- .lapply(
		parallel = parallel,
		X = setNames(seq_along(discrete), names(discrete)),
		FUN = function(j) {
			if (is.null(with)) {
				x <- discrete[, j, with = FALSE]
				agg_x <- x[, list(frequency = .N), by = names(x)]
			} else {
				if (!is.numeric(data[[with]])) stop("`with` should be continuous!")
				x <- data.table(discrete[, j, with = FALSE], "agg_by" = data[[with]])
				agg_x <- x[, list(frequency = sum(agg_by, na.rm = TRUE)), by = eval(names(x)[1])]
			}
			if (order_bar) {
				base_plot <- ggplot(agg_x, aes(x = reorder(get(names(agg_x)[1]), frequency), y = frequency))
			} else {
				base_plot <- ggplot(agg_x, aes_string(x = names(agg_x)[1], y = "frequency"))
			}
			base_plot +
				geom_bar(stat = "identity") +
				coord_flip() +
				xlab(names(agg_x)[1]) + ylab(ifelse(is.null(with), "Frequency", toTitleCase(with)))
		}
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
