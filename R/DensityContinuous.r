#' Visualize density estimates for continuous features
#'
#' This function visualizes density estimates for each continuous feature.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @param \dots other arguments to be passed to \link{geom_density}.
#' @keywords densitycontinuous
#' @import data.table
#' @import ggplot2
#' @importFrom scales comma percent
#' @importFrom stats na.omit
#' @import gridExtra
#' @export
#' @examples
#' # load library
#' library(data.table)
#'
#' # plot using iris data
#' DensityContinuous(iris)
#'
#' # plot using random data
#' set.seed(1)
#' data <- cbind(sapply(1:9, function(x) {
#'           runif(500, min = sample(100, 1), max = sample(1000, 1))
#'         }))
#' DensityContinuous(data)

DensityContinuous <- function(data, ...) {
  if (!is.data.table(data)) {data <- data.table(data)}
  # stop if no continuous features
  if (SplitColType(data)$num_continuous == 0) stop("No Continuous Features")
  # get continuous features
  continuous <- SplitColType(data)$continuous
  # get dimension
  n <- nrow(continuous)
  p <- ncol(continuous)
  # calculate number of pages if showing 16 features on each page
  pages <- ceiling(p/16)
  for (pg in 1:pages) {
    # subset data by column
    subset_data <- continuous[, (16 * pg - 15):min(p, 16 * pg), with = FALSE]
    # create ggplot object
    plot <- lapply(seq_along(subset_data),
                   function(j) {
                     x <- na.omit(subset_data[, j, with = FALSE])
                     ggplot(x, aes_string(x = names(x))) +
                       geom_density(fill = "black", alpha = 0.4, ...) +
                       scale_x_continuous(labels = comma) +
                       scale_y_continuous(labels = percent) +
                       ylab("Density")
                   })
    # print plot object
    if (pages > 1) {
      suppressWarnings(do.call(grid.arrange, c(plot, ncol = 4, nrow = 4)))
    } else {
      suppressWarnings(do.call(grid.arrange, plot))
    }
  }
}
