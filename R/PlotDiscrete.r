##bar chart for discrete features
PlotDiscrete <- function(data, na.rm=TRUE, maxcat=50) {
  if (!is.data.table(data)) {data <- data.table(data)}
  # get discrete features
  discrete <- SplitColType(data)$discrete
  # get number of categories for each feature
  n_cat <- sapply(discrete, function(x) {length(levels(x))})
  ign_ind <- which(n_cat > maxcat)
  if (length(ign_ind)>0) {
    set(discrete, j=ign_ind, value=NULL)
    warning(length(ign_ind), " columns ignored with more than ", maxcat, " categories.\n", paste0(names(ign_ind), ": ", n_cat[ign_ind], " categories", collapse = "\n"))
  }
  # get dimension
  n <- nrow(discrete)
  p <- ncol(discrete)
  # calculate number of pages if showing 9 features on each page
  pages <- ceiling(p/9)
  for (pg in 1:pages) {
    # subset data by column
    subset_data <- discrete[, (9*pg-8):min(p, 9*pg), with=FALSE]
    # create ggplot object
    plot <- lapply(seq_along(subset_data),
                   function(j) {
                     x <- subset_data[, j, with=FALSE]
                     agg_x <- x[, list(frequency=.N), by=names(x)]
                     if (na.rm) {agg_x <- na.omit(agg_x)}
                     ggplot(agg_x, aes_string(x=names(agg_x)[1], y="frequency")) + geom_bar(stat="identity") +
                       scale_y_continuous(labels=comma) + coord_flip() + ylab("Frequency")
                   })
    # print plot object
    suppressWarnings(do.call(grid.arrange, plot))
  }
}