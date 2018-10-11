#' Visualize density estimates for continuous features
#'
#' This function visualizes density estimates for each continuous feature.
#' @param data input data
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param \dots other arguments to be passed to \link{geom_density}.
#' @keywords plot_density
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @import data.table
#' @import ggplot2
#' @importFrom stats na.omit
#' @import gridExtra
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

plot_density <- function(data, title = NULL, ggtheme = theme_gray(), theme_config = list(), ...) {
  if (!is.data.table(data)) data <- data.table(data)
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
          geom_density(...) +
          ylab("Density") +
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
