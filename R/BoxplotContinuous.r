#' Create boxplot for continuous features
#'
#' This function creates boxplot for each continuous feature.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @param five_points_only logical, indicating if plot with only minimum, Q1, Q2, Q3 and maximum, i.e., 5 points. The default is \code{FALSE}. More information in 'Details' section.
#' @keywords boxplotcontinuous
#' @details Setting \code{five_points_only} to \code{TRUE} could improve performance dramatically when dealing with large skewed datasets. Outliers (except for minimum and maximum) and whiskers may not be plotted.
#' @import data.table
#' @import ggplot2
#' @import scales
#' @import gridExtra
#' @import reshape2
#' @export
#' @examples
#' # load library
#' library(data.table)
#'
#' # plot using iris data
#' BoxplotContinuous(iris)
#' BoxplotContinuous(iris, five_points_only=TRUE)
#'
#' # plot using random data
#' data <- data.table(matrix(rnorm(16000000), ncol=16))
#' BoxplotContinuous(data)
#' BoxplotContinuous(data, five_points_only=TRUE)

BoxplotContinuous <- function(data, five_points_only=FALSE) {
  if (!is.data.table(data)) {data <- data.table(data)}
  # get continuous features
  continuous <- SplitColType(data)$continuous
  # get dimension
  n <- nrow(continuous)
  p <- ncol(continuous)
  # calculate number of pages if showing 16 features on each page
  pages <- ceiling(p/16)
  for (pg in 1:pages) {
    # subset data by column
    subset_data <- continuous[, (16*pg-15):min(p, 16*pg), with=FALSE]
    # melt data and calculate quantiles for plotting
    if (five_points_only) {
      plot_data <- data.table(t(do.call(rbind, lapply(subset_data, quantile))))
    } else {
      plot_data <- subset_data
    }
    # create ggplot object
    plot <- lapply(seq_along(plot_data),
                   function(j) {
                     ggplot(plot_data, aes_string(x=names(plot_data)[j], y=names(plot_data)[j])) +
                       geom_boxplot() +
                       scale_y_continuous(labels=comma) +
                       ylab("Value")
                   })
    # print plot object
    suppressWarnings(do.call(grid.arrange, c(plot, ncol=4, nrow=4)))
  }
}
