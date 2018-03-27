#' Create bar charts for discrete features
#'
#' This function creates frequency bar charts for each discrete feature.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @param na.rm logical, indicating if missing values should be removed for each feature. The default is \code{TRUE}.
#' @param maxcat maximum categories allowed for each feature. The default is 50. More information in 'Details' section.
#' @param order_bar logical, indicating if bars should be ordered.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @keywords plot_bar
#' @aliases BarDiscrete
#' @details If a discrete feature contains more categories than \code{maxcat} specifies, it will not be passed to the plotting function.
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @import data.table
#' @import ggplot2
#' @importFrom scales comma
#' @importFrom stats na.omit reorder
#' @import gridExtra
#' @export plot_bar BarDiscrete
#' @examples
#' # Load diamonds dataset from ggplot2
#' library(ggplot2)
#' data("diamonds", package = "ggplot2")
#'
#' # Plot bar charts for diamonds dataset
#' plot_bar(diamonds)
#' plot_bar(diamonds, maxcat = 5)
#'
#' # Plot bar charts with preset ggplot2 themes
#' plot_bar(diamonds, ggtheme = theme_light())
#' plot_bar(diamonds, ggtheme = theme_minimal(base_size = 20))
#'
#' # Plot bar charts with customized theme components
#' plot_bar(diamonds,
#' theme_config = list(
#'   "plot.background" = element_rect(fill = "yellow"),
#'   "aspect.ratio" = 1
#' ))

plot_bar <- function(data, na.rm = TRUE, maxcat = 50, order_bar = TRUE, title = NULL, ggtheme = theme_gray(), theme_config = list()) {
  ## Declare variable first to pass R CMD check
  frequency <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) {
    data <- data.table(data)
  }
  ## Stop if no discrete features
  if (split_columns(data)$num_discrete == 0) stop("No Discrete Features")
  ## Get discrete features
  discrete <- split_columns(data)$discrete
  ## Get number of categories for each feature
  n_cat <- sapply(discrete, function(x) {
    length(unique(x))
  })
  ign_ind <- which(n_cat > maxcat)
  if (length(ign_ind) > 0) {
    set(discrete, j = ign_ind, value = NULL)
    message(length(ign_ind), " columns ignored with more than ", maxcat, " categories.\n", paste0(names(ign_ind), ": ", n_cat[ign_ind], " categories\n"))
  }
  ## Get dimension
  n <- nrow(discrete)
  p <- ncol(discrete)
  ## Calculate number of pages
  pages <- ceiling(p / 9L)
  for (pg in seq.int(pages)) {
    ## Subset data by column
    subset_data <- discrete[, seq.int(9L * pg - 8L, min(p, 9L * pg)), with = FALSE]
    n_col <- ifelse(ncol(subset_data) %% 3L, ncol(subset_data) %/% 3L + 1L, ncol(subset_data) %/% 3L)
    ## Create ggplot object
    plot <- lapply(
      seq_along(subset_data),
      function(j) {
        x <- subset_data[, j, with = FALSE]
        agg_x <- x[, list(frequency = .N), by = names(x)]
        if (na.rm) {
          agg_x <- na.omit(agg_x)
        }
        if (order_bar) {
          base_plot <- ggplot(agg_x, aes(x = reorder(get(names(agg_x)[1]), frequency), y = frequency))
        } else {
          base_plot <- ggplot(agg_x, aes_string(x = names(agg_x)[1], y = "frequency"))
        }
        base_plot +
          geom_bar(stat = "identity") +
          scale_y_continuous(labels = comma) +
          coord_flip() +
          xlab(names(agg_x)[1]) + ylab("Frequency") +
          ggtheme +
          do.call(theme, theme_config)
      }
    )
    ## Print plot object
    if (pages > 1) {
      suppressWarnings(do.call(grid.arrange, c(plot, ncol = n_col, nrow = 3L, top = title)))
    } else {
      suppressWarnings(do.call(grid.arrange, c(plot, top = title)))
    }
  }
}

BarDiscrete <- function(data, na.rm = TRUE, maxcat = 50, order_bar = TRUE, title = NULL) {
  .Deprecated("plot_bar")
  plot_bar(data = data, na.rm = na.rm, maxcat = maxcat, order_bar = order_bar, title = title)
}
