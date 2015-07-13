#' Create correlation heatmap for discrete features
#'
#' This function creates a correlation heatmap for all discrete categories.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @keywords correlationdiscrete
#' @details The function first transposes all discrete categories into columns with binary outcomes (see \link{model.matrix}), then calculates the correlation matrix (see \link{cor}) and plots it.
#' @import data.table
#' @import ggplot2
#' @import reshape2
#' @export
#' @examples
#' # correlation of discrete categories from diamonds dataset
#' library(ggplot2)
#' data(diamonds)
#' CorrelationDiscrete(diamonds)

CorrelationDiscrete <- function(data) {
  if (!is.data.table(data)) {data <- data.table(data)}
  # stop if no discrete features
  if (SplitColType(data)$num_discrete == 0) return("No Discrete Features")
  # get discrete features
  discrete <- SplitColType(data.table(data))$discrete
  # calculate categorical correlation and melt into tidy data format
  discrete_pivot <- model.matrix(as.formula(paste0("~ ", paste0(names(discrete), collapse="+"))), data=discrete)[, -1]
  plot_data <- melt(cor(discrete_pivot))
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

