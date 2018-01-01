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
#' # plot iris data
#' plot_histogram(iris)
#'
#' # plot random data with customized geom_histogram settings
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
  ## Calculate number of pages
  pages <- ceiling(p / 16L)
  for (pg in seq.int(pages)) {
    ## Subset data by column
    subset_data <- continuous[, seq.int(16L * pg - 15L, min(p, 16L * pg)), with = FALSE]
    n_col <- ifelse(ncol(subset_data) %% 4L, ncol(subset_data) %/% 4L + 1L, ncol(subset_data) %/% 4L)
    ## Create ggplot object
    plot <- lapply(seq_along(subset_data),
                   function(j) {
                     x <- na.omit(subset_data[, j, with = FALSE])
                     ggplot(x, aes_string(x = names(x))) +
                       geom_histogram(bins = 30L, colour = "black", alpha = 0.4, ...) +
                       scale_x_continuous(labels = comma) +
                       scale_y_continuous(labels = comma) +
                       ylab("Frequency")
                   })
    ## Print plot object
    if (pages > 1) {
      suppressWarnings(do.call(grid.arrange, c(plot, ncol = n_col, nrow = 4L, top = title)))
    } else {
      suppressWarnings(do.call(grid.arrange, c(plot, top = title)))
    }
  }
}

HistogramContinuous <- function(data, title = NULL, ...) {
  .Deprecated("plot_histogram")
  plot_histogram(data = data, title = title, ...)
}
