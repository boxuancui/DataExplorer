#' Visualize density estimates for continuous features
#'
#' This function visualizes density estimates for each continuous feature.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @param title plot title
#' @param \dots other arguments to be passed to \link{geom_density}.
#' @keywords plot_density
#' @aliases DensityContinuous
#' @import data.table
#' @import ggplot2
#' @importFrom scales comma percent
#' @importFrom stats na.omit
#' @import gridExtra
#' @export plot_density DensityContinuous
#' @seealso \link{geom_density} \link{plot_histogram}
#' @examples
#' # plot using iris data
#' plot_density(iris)
#'
#' # plot using random data
#' set.seed(1)
#' data <- cbind(sapply(1:9, function(x) {
#'           runif(500, min = sample(100, 1), max = sample(1000, 1))
#'         }))
#' plot_density(data)

plot_density <- function(data, title = NULL, ...) {
  if (!is.data.table(data)) {
    data <- data.table(data)
  }
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
    plot <- lapply(
      seq_along(subset_data),
      function(j) {
        x <- na.omit(subset_data[, j, with = FALSE])
        ggplot(x, aes_string(x = names(x))) +
          geom_density(fill = "black", alpha = 0.4, ...) +
          scale_x_continuous(labels = comma) +
          scale_y_continuous(labels = percent) +
          ylab("Density")
      }
    )
    ## Print plot object
    if (pages > 1) {
      suppressWarnings(do.call(grid.arrange, c(plot, ncol = n_col, nrow = 4L, top = title)))
    } else {
      suppressWarnings(do.call(grid.arrange, c(plot, top = title)))
    }
  }
}

DensityContinuous <- function(data, title = NULL, ...) {
  .Deprecated("plot_density")
  plot_density(data = data, title = title, ...)
}
