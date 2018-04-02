#' Create histogram for continuous features
#'
#' This function creates histogram for each continuous feature.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param \dots other arguments to be passed to \link{geom_histogram}.
#' @keywords plot_histogram
#' @aliases HistogramContinuous
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @import data.table
#' @import ggplot2
#' @importFrom scales comma
#' @importFrom stats na.omit
#' @import gridExtra
#' @export plot_histogram HistogramContinuous
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

plot_histogram <- function(data, title = NULL, ggtheme = theme_gray(), theme_config = list(), ...) {
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
    setnames(subset_data, make.names(names(subset_data)))
    n_col <- ifelse(ncol(subset_data) %% 4L, ncol(subset_data) %/% 4L + 1L, ncol(subset_data) %/% 4L)
    ## Create ggplot object
    plot <- lapply(
      seq_along(subset_data),
      function(j) {
        x <- na.omit(subset_data[, j, with = FALSE])
        ggplot(x, aes_string(x = names(x))) +
          geom_histogram(bins = 30L, ...) +
          scale_x_continuous(labels = comma) +
          scale_y_continuous(labels = comma) +
          ylab("Frequency") +
          ggtheme +
          do.call(theme, theme_config)
      }
    )
    ## Print plot object
    if (pages > 1) {
      suppressWarnings(do.call(grid.arrange, c(plot, ncol = n_col, nrow = 4L, top = title, bottom = paste("Page", pg))))
    } else {
      suppressWarnings(do.call(grid.arrange, c(plot, top = title)))
    }
  }
}

HistogramContinuous <- function(data, title = NULL, ...) {
  .Deprecated("plot_histogram")
  plot_histogram(data = data, title = title, ...)
}
