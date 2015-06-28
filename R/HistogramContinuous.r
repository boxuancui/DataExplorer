## histogram for continuous features
HistogramContinuous <- function(data) {
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
    # create ggplot object
    plot <- lapply(seq_along(subset_data),
                   function(j) {
                     x <- na.omit(subset_data[, j, with=FALSE])
                     ggplot(x, aes_string(x=names(x))) +
                       geom_histogram(aes(y=..density..), binwidth=diff(range(x[, 1, with=FALSE]))/30, colour="black", alpha=0.4) +
                       ylab("Density")
                   })
    # print plot object
    suppressWarnings(do.call(grid.arrange, plot))
  }
}