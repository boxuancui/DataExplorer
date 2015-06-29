#' Create bar charts for discrete features
#'
#' This function plots bar charts for each discrete feature which displays the frequency of all categories.
#' @param data input data to be plotted, in either \code{\link{data.frame}} or \code{\link{data.table}} format.
#' @param na.rm logical, indicating if missing values should be removed for each feature. The default is \code{TRUE}.
#' @param maxcat maximum categories allowed for each feature. The default is 50. More information in 'Details' section.
#' @keywords plotdiscrete
#' @details If a discrete feature contains more categories than \code{maxcat} specifies, it will not be passed to the plotting function. Instead, it will be passed to warnings messages with number of categories.
#' @import data.table
#' @export
#' @examples
#' # load packages
#' library(ggplot2)
#' library(data.table)
#' # load diamonds dataset from ggplot2
#' data("diamonds")
#' # making more columns as factors
#' diamonds <- data.table(diamonds)
#' diamonds[, color_clarity:=as.factor(paste0(color, "_", clarity))]
#' diamonds[, cut_color:=as.factor(paste0(cut, "_", color))]
#' diamonds[, cut_clarity:=as.factor(paste0(cut, "_", clarity))]
#' diamonds[, color_clarity:=as.factor(paste0(color, "_", clarity))]
#' diamonds2 <- dcast.data.table(diamonds,
#'                               carat+cut+color+clarity+cut_color+cut_clarity+color_clarity+depth+table+x+y+z~color_clarity,
#'                               fun=sum,
#'                               value.var="price",
#'                               fill=NA)
#' for (col in names(diamonds2)[grep("D_|E_|F_|G_|H_|I_|J_", names(diamonds2))]) {
#'   set(diamonds2, j=col, value=as.factor(diamonds2[[col]]))
#' }
#' # plot bar charts for discrete features
#' PlotDiscrete(diamonds2, maxcat=100)

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