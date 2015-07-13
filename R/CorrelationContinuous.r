#' Create correlation heatmap for continuous features
#'
#' This function creates a correlation heatmap for all continuous features.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @keywords correlationcontinuous
#' @import data.table
#' @import ggplot2
#' @import reshape2
#' @export
#' @examples
#' # correlation of features from mtcars dataset
#' data(mtcars)
#' CorrelationContinuous(mtcars)

CorrelationContinuous <- function(data) {
  if (!is.data.table(data)) {data <- data.table(data)}
  # get continuous features
  continuous <- SplitColType(data)$continuous
  # calculate correlation and melt into tidy data format
  plot_data <- melt(cor(continuous))
  # create ggplot object
  plot <- ggplot(plot_data, aes(x=Var1, y=Var2, fill=value)) +
    geom_tile() +
    geom_text(aes(label=round(value, 2))) +
    scale_fill_gradient2("Correlation Meter", low="#0571b0", high="#ca0020", space="Lab") +
    xlab("Features") + ylab("Features") +
    theme(legend.position="bottom")
  # print plot object
  print(plot)
}

