## boxplot for continuous features
BoxplotContinuous <- function(data) {
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
    plot_data <- plot_full_data[, list(value=quantile(value)), by=variable]
    # create ggplot object
    plot <- ggplot(plot_data, aes(x=variable, y=value)) + geom_boxplot() +
      scale_y_continuous(labels=comma) + facet_wrap(~variable, ncol=4, scales="free") +
      xlab("Features") + ylab("Value")
    # print plot object
    print(plot)
  }
}