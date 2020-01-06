#' Create correlation heatmap for discrete features
#'
#' This function creates a correlation heatmap for all discrete categories.
#' @param data input data
#' @param type column type to be included in correlation calculation. "all" for all columns, "discrete" for discrete features, "continuous" for continuous features.
#' @param maxcat maximum categories allowed for each discrete feature. The default is 20.
#' @param cor_args a list of other arguments to \link{cor}
#' @param geom_text_args a list of other arguments to \link{geom_text}
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @return invisibly return the ggplot object
#' @keywords plot_correlation
#' @details For discrete features, the function first dummifies all categories, then calculates the correlation matrix (see \link{cor}) and plots it.
#' @import data.table
#' @import ggplot2
#' @importFrom stats cor
#' @export
#' @examples
#' plot_correlation(iris)
#' plot_correlation(iris, type = "c")
#' plot_correlation(airquality, cor_args = list("use" = "pairwise.complete.obs"))

plot_correlation <- function(data, type = c("all", "discrete", "continuous"), maxcat = 20L,
                             cor_args = list(),
                             geom_text_args = list(),
                             title = NULL,
                             ggtheme = theme_gray(),
                             theme_config = list("legend.position" = "bottom",
                                                 "axis.text.x" = element_text(angle = 90))) {
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
  cor_args_list <- list("x" = final_data)
  plot_data <- reshape2::melt(do.call("cor", c(cor_args_list, cor_args)))
  ## Create ggplot object
  output <- ggplot(plot_data, aes(x = Var1, y = Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2("Correlation Meter", limits = c(-1, 1), low = "#0571b0", high = "#ca0020", space = "Lab") +
    xlab("Features") + ylab("Features")
  if (ncol(final_data) <= 20) {
    geom_text_args_list <- list("mapping" = aes(label = round(value, 2)))
    output <- output +
      do.call("geom_text", c(geom_text_args_list, geom_text_args))
  }
  ## Plot object
  class(output) <- c("single", class(output))
  plotDataExplorer(
    plot_obj = output,
    title = title,
    ggtheme = ggtheme,
    theme_config = theme_config
  )
}
