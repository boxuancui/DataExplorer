#' Create correlation heatmap for continuous features
#'
#' This function creates a correlation heatmap for all continuous features.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @param \dots other arguments to be passed to \link{cor}.
#' @keywords correlationcontinuous
#' @import data.table
#' @import ggplot2
#' @importFrom stats cor
#' @export
#' @examples
#' # correlation of features from mtcars dataset
#' data(mtcars)
#' CorrelationContinuous(mtcars)

CorrelationContinuous <- function(data, ...) {
  ## Declare variable first to pass R CMD check
  Var1 <- Var2 <- value <- NULL
  ## Set data to data.table
  if (!is.data.table(data)) {data <- data.table(data)}
  ## Stop if no continuous features
  if (SplitColType(data)$num_continuous <= 1) stop("Not Enough Continuous Features")
  ## Get continuous features
  continuous <- SplitColType(data)$continuous
  ## Calculate correlation and melt into tidy data format
  plot_data <- reshape2::melt(cor(continuous, ...))
  ## Create ggplot object
  plot <- ggplot(plot_data, aes(x = Var1, y = Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2("Correlation Meter", low = "#0571b0", high = "#ca0020", space = "Lab") +
    xlab("Features") + ylab("Features") +
    theme(legend.position = "bottom", axis.text.x = element_text(angle = 90))
  if (ncol(continuous) <= 20) {plot <- plot + geom_text(aes(label = round(value, 2)))}
  ## Print plot object
  print(plot)
}
