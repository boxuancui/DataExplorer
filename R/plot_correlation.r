#' Create correlation heatmap for discrete features
#'
#' This function creates a correlation heatmap for all discrete categories.
#' @param data input data
#' @param type column type to be included in correlation calculation. "all" for all columns, "discrete" for discrete features, "continuous" for continuous features.
#' @param maxcat maximum categories allowed for each discrete feature. The default is 20.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param \dots other arguments to be passed to \link{cor}.
#' @keywords plot_correlation
#' @aliases CorrelationDiscrete CorrelationContinuous
#' @details For discrete features, the function first dummifies all categories, then calculates the correlation matrix (see \link{cor}) and plots it.
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @import data.table
#' @import ggplot2
#' @importFrom stats cor
#' @export plot_correlation CorrelationDiscrete CorrelationContinuous
#' @examples
#' # Load diamonds dataset from ggplot2
#' data("diamonds", package = "ggplot2")
#'
#' # Plot correlation heatmap
#' plot_correlation(diamonds)
#' plot_correlation(diamonds, maxcat = 5)
#' plot_correlation(diamonds, type = "c")
#' plot_correlation(diamonds, type = "d")

plot_correlation <- function(data, type = c("all", "discrete", "continuous"), maxcat = 20L, title = NULL, ggtheme = theme_gray(), theme_config = list("legend.position" = "bottom", "axis.text.x" = element_text(angle = 90)), ...) {
  ## Declare variable first to pass R CMD check
  Var1 <- Var2 <- value <- NULL
  ## Set data to data.table
  if (!is.data.table(data)) data <- data.table(data)
  ## Split data
  split_data <- split_columns(data)
  ## Match column type and raise appropriate alerts if necessary
  col_type <- match.arg(type)
  if (col_type == "continuous") {
    if (split_data$num_continuous == 0) stop("Not enough continuous features!")
    final_data <- split_data$continuous
  }

  if (col_type == "discrete") {
    if (split_data$num_discrete == 0) stop("No discrete features found!")
    final_data <- split_columns(dummify(split_data$discrete, maxcat = maxcat))$continuous
  }

  if (col_type == "all") {
    if (split_data$num_discrete == 0) {
      final_data <- data
    } else {
      final_data <- split_columns(dummify(data, maxcat = maxcat))$continuous
    }
  }

  ## Calculate correlation and melt into tidy data format
  plot_data <- reshape2::melt(cor(final_data, ...))
  ## Create ggplot object
  plot <- ggplot(plot_data, aes(x = Var1, y = Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2("Correlation Meter", limits = c(-1, 1), low = "#0571b0", high = "#ca0020", space = "Lab") +
    xlab("Features") + ylab("Features") +
    ggtitle(label = title) +
    ggtheme +
    do.call(theme, theme_config)
  if (ncol(final_data) <= 20) {
    plot <- plot + geom_text(aes(label = round(value, 2)))
  }
  ## Print plot object
  print(plot)
}

CorrelationDiscrete <- function(data, maxcat = 20, title = NULL, ...) {
  .Deprecated("plot_correlation")
  plot_correlation(data = data, type = "discrete", maxcat = maxcat, title = title, ...)
}

CorrelationContinuous <- function(data, title = NULL, ...) {
  .Deprecated("plot_correlation")
  plot_correlation(data = data, type = "continuous", title = title, ...)
}
