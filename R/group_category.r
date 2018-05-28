#' Group categories for discrete features
#'
#' Sometimes discrete features have sparse categories. This function will group the sparse categories for a discrete feature based on a given threshold.
#' @param data input data
#' @param feature name of the discrete feature to be collapsed.
#' @param threshold the bottom x\% categories to be grouped, e.g., if set to 20\%, categories with cumulative frequency of the bottom 20\% will be grouped
#' @param update logical, indicating if the data should be modified. The default is \code{FALSE}. Setting to \code{TRUE} will modify the input \link{data.table} object directly. Otherwise, input class will be returned.
#' @param measure name of feature to be used as an alternative measure.
#' @param category_name name of the new category if update is set to \code{TRUE}. The default is "OTHER".
#' @param exclude categories to be excluded from grouping when update is set to \code{TRUE}.
#' @keywords group_category
#' @aliases CollapseCategory
#' @return If \code{update} is set to \code{FALSE}, returns categories with cumulative frequency less than the input threshold. The output class will match the class of input data.
#' If \code{update} is set to \code{TRUE}, updated data will be returned, and the output class will match the class of input data.
#' @details If a continuous feature is passed to the argument \code{feature}, it will be force set to \link{character-class}.
#' @import data.table
#' @export group_category CollapseCategory
#' @examples
#' # load packages
#' library(data.table)
#'
#' # generate data
#' data <- data.table("a" = as.factor(round(rnorm(500, 10, 5))), "b" = rexp(500, 1:500))
#'
#' # view cumulative frequency without collpasing categories
#' group_category(data, "a", 0.2)
#'
#' # view cumulative frequency based on another measure
#' group_category(data, "a", 0.2, measure = "b")
#'
#' # group bottom 20% categories based on cumulative frequency
#' group_category(data, "a", 0.2, update = TRUE)
#' plot_bar(data)
#'
#' # exclude categories from being grouped
#' dt <- data.table("a" = c(rep("c1", 25), rep("c2", 10), "c3", "c4"))
#' group_category(dt, "a", 0.8, update = TRUE, exclude = c("c3", "c4"))
#' plot_bar(dt)

group_category <- function(data, feature, threshold, measure, update = FALSE, category_name = "OTHER", exclude = NULL) {
  ## Declare variable first to pass R CMD check
  cnt <- pct <- cum_pct <- NULL
  ## Check if input is data.table
  is_data_table <- is.data.table(data)
  ## Detect input data class
  data_class <- class(data)
  ## Set data to data.table
  if (!is_data_table) data <- data.table(data)
  ## Set feature to discrete
  set(data, j = feature, value = as.character(data[[feature]]))
  if (missing(measure)) {
    ## Count frequency of each category and order in descending order
    var <- data[, list(cnt = .N), by = feature][order(-cnt)]
  } else {
    var <- data[, list(cnt = sum(get(measure))), by = feature][order(-cnt)]
  }
  ## Calcualte cumulative frequency for each category
  var[, pct := cnt / sum(cnt)][, cum_pct := cumsum(pct)]
  ## Identify categories not to be collapased based on input threshold
  top_cat <- var[cum_pct <= (1 - threshold), get(feature)]
  ## Collapse categories if update is true, else return distribution for analysis
  if (update) {
    data[!(get(feature) %in% c(top_cat, exclude)), c(feature) := category_name]
    if (!is_data_table) {
      class(data) <- data_class
      return(data)
    }
  } else {
    output <- var[cum_pct <= (1 - threshold)]
    class(output) <- data_class
    return(output)
  }
}

CollapseCategory <- function(data, feature, threshold, measure, update = FALSE, category_name = "OTHER", exclude = NULL) {
  .Deprecated("group_category")
  group_category(data = data, feature = feature, threshold = threshold, measure = measure, update = update, category_name = category_name, exclude = exclude)
}
