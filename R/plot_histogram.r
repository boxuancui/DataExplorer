#' Create histogram for continuous features
#'
#' This function creates histogram for each continuous feature.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @param title plot title
#' @param \dots other arguments to be passed to \link{geom_histogram}.
#' @keywords plot_histogram
#' @aliases HistogramContinuous
#' @import data.table
#' @import ggplot2
#' @importFrom scales comma
#' @importFrom stats na.omit
#' @import gridExtra
#' @export plot_histogram HistogramContinuous
#' @seealso \link{geom_histogram} \link{plot_density}
#' @examples
#' # load library
#' library(data.table)
#'
#' # plot using iris data
#' plot_histogram(iris)
#'
#' # plot using random data
#' set.seed(1)
#' data <- cbind(sapply(1:9, function(x) {rnorm(10000, sd = 30 * x)}))
#' plot_histogram(data, breaks = seq(-400, 400, length = 10))

plot_histogram <- function(data, title = NULL, ...) {
  if (!is.data.table(data)) {data <- data.table(data)}
  ## Stop if no continuous features
  if (split_columns(data)$num_continuous == 0) stop("No Continuous Features")
  ## Get continuous features
  continuous <- split_columns(data)$continuous
  ## Get dimension
  n <- nrow(continuous)
  p <- ncol(continuous)
  ## Calculate number of pages if showing 16 features on each page
  pages <- ceiling(p/16)
  for (pg in 1:pages) {
    ## Subset data by column
    subset_data <- continuous[, (16 * pg - 15):min(p, 16 * pg), with = FALSE]
    ## Create ggplot object
    plot <- lapply(seq_along(subset_data),
                   function(j) {
                     x <- na.omit(subset_data[, j, with = FALSE])
                     ggplot(x, aes_string(x = names(x))) +
                       geom_histogram(bins = 30, colour = "black", alpha = 0.4, ...) +
                       scale_x_continuous(labels = comma) +
                       scale_y_continuous(labels = comma) +
                       ylab("Frequency")
                   })
    ## Print plot object
    if (pages > 1) {
      suppressWarnings(do.call(grid.arrange, c(plot, ncol = 4, nrow = 4, top = title)))
    } else {
      suppressWarnings(do.call(grid.arrange, c(plot, top = title)))
    }
  }
}

HistogramContinuous <- function(data, title = NULL, ...) {
  .Deprecated("plot_histogram")
  plot_histogram(data = data, title = title, ...)
}
