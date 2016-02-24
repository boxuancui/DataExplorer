#' Collapse categories for discrete features
#'
#' Sometimes discrete features have sparse categories. This function will collapse the sparse categories for a discrete feature based on a given threshold.
#' @param data input data, in either \link{data.frame} or \link{data.table} format.
#' @param feature name of the discrete feature to be collapsed.
#' @param threshold the percentage threshold to collapse categories, e.g., if 80\%, categories with cumulative frequency over 80\% will be collapsed.
#' @param update logical, indicating if the data should be modified. Setting to \code{FALSE} will return the categories with cumulative frequency. The default is \code{TRUE}.
#' @keywords collapsecategory
#' @return if update is set to \code{FALSE}, returns a \link{data.table} object containing categories with cumulative frequency less than the input threshold.
#' @details If a continuous feature is passed to the argument \code{feature}, it will be force set to \link{character-class}.
#' @import data.table
#' @export
#' @examples
#' # load packages
#' library(data.table)
#' # generate data
#' data <- data.table("a" = as.factor(round(rnorm(500, 10, 5))))
#'
#' # view cumulative frequency without collpasing categories
#' CollapseCategory(data, "a", 0.8, update = FALSE)
#'
#' # collapse bottom 20\% categories based on cumulative frequency
#' CollapseCategory(data, "a", 0.8)

CollapseCategory <- function(data, feature, threshold, update = TRUE) {
  # set data to data.table
  if (!is.data.table(data)) {data <- data.table(data)}
  # set feature to discrete
  set(data, j = feature, value = as.character(data[[feature]]))
  # count frequency of each category and order in descending order
  var <- data[, .(cnt = .N), by = feature][order(-cnt)]
  # calcualte cumulative frequency for each category
  var[, pct := cnt / sum(cnt)][, cum_pct := cumsum(pct)]
  # identify categories not to be collapased based on input threshold
  top_cat <- var[cum_pct <= threshold, get(feature)]
  # collapse categories if update is true
  if (update) {
    data[!(get(feature) %in% top_cat), c(feature) := "OTHER"]
  } else {
    return(var[cum_pct <= threshold])
  }
}
