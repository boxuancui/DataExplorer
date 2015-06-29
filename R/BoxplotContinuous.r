#' Create boxplot for continuous features
#'
#' This function creates boxplot for each continuous feature.
#' @param data input data to be plotted, in either \code{\link{data.frame}} or \code{\link{data.table}} format.
#' @param five_points_only logical, indicating if plot with only minimum, Q1, Q2, Q3 and maximum, i.e., 5 points. The default is \code{FALSE}. More information in 'Details' section.
#' @keywords boxplotcontinuous
#' @details Setting \code{five_points_only} to \code{TRUE} could improve performance dramatically when dealing with large skewed datasets. Outliers (except for minimum and maximum) and whiskers may not be plotted.
#' @import data.table
#' @export
#' @examples
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
    plot_full_data <- suppressWarnings(melt(subset_data, measure.vars = names(subset_data), na.rm = TRUE))
    if (five_points_only) {
      plot_data <- plot_full_data[, list(value=quantile(value)), by=variable]
    } else {
      plot_data <- plot_full_data
    }
    # create ggplot object
    plot <- ggplot(plot_data, aes(x=variable, y=value)) + geom_boxplot() +
      scale_y_continuous(labels=comma) + facet_wrap(~variable, ncol=4, scales="free") +
      xlab("Features") + ylab("Value")
    # print plot object
    print(plot)
  }
}