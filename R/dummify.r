#' Dummify discrete features to binary columns
#'
#' Data dummification is also known as one hot encoding or feature binarization. It turns each category to a distinct column with binary (numeric) values.
#' @param data input data, in either \link{data.frame} or \link{data.table} format.
#' @param maxcat maximum categories allowed for each discrete feature. The default is 50.
#' @keywords dummify
#' @note This is different from \link{model.matrix}, where the latter aims to create a full rank matrix for regression-like use cases. If your intention is to create a design matrix, use \link{model.matrix} instead.
#' @return dummified dataset (discrete features only) preserving original features. However, column order might be different.
#' @import data.table
#' @import reshape2
#' @export
#' @examples
#' ## Dummify iris dataset
#' str(dummify(iris))
#'
#' ## Dummify diamonds dataset ignoring features with more than 5 categories
#' data("diamonds", package = "ggplot2")
#' str(dummify(diamonds, maxcat = 5))

dummify <- function(data, maxcat = 50L) {
  ## Declare variable first to pass R CMD check
  discrete_id <- NULL
  ## Check if input is data.table
  is_data_table <- is.data.table(data)
  ## Detect input data class
  data_class <- class(data)
  ## Set data to data.table
  if (!is.data.table(data)) {data <- data.table(data)}
  ## Split data
  split_data <- split_columns(data)
  continuous <- split_data$continuous
  ## Scan feature type
  if (split_data$num_discrete > 0) {
    discrete <- split_data$discrete
    ## Get number of categories for each feature
    ind <- .ignoreCat(discrete, maxcat)
    n_true_discrete <- split_data$num_discrete - length(ind)
    if (all(split_data$num_discrete, length(ind), !n_true_discrete)) {
      warning("Ignored all discrete features since `maxcat` set to ", maxcat, " categories!")
      final_data <- data
    } else {
      if (n_true_discrete > 0) {
        if (length(ind) > 0) {
          message(length(ind), " features with more than ", maxcat, " categories ignored!\n", paste0(names(ind), ": ", as.numeric(ind), " categories\n"))
        }
        ## Calculate categorical correlation and melt into tidy data format
        discrete[, discrete_id := .I]
        discrete_pivot <- Reduce(
          function(x, y) {merge(x, y, by = "discrete_id")},
          c(
            list(discrete[, c("discrete_id", names(ind)), with = FALSE]),
            lapply(names(discrete)[!(names(discrete) %in% c("discrete_id", names(ind)))], function(x) {
              dcast.data.table(discrete, discrete_id ~ make.names(paste0(x, "_", get(x))), length, value.var = "discrete_id")
            })
          )
        )
        drop_columns(discrete_pivot, "discrete_id")
        if (split_data$num_continuous == 0) {
          final_data <- discrete_pivot
        } else {
          final_data <- cbind(continuous, discrete_pivot)
        }
      }
    }
  } else {
    warning("No discrete features found! Nothing is dummified!")
    final_data <- continuous
  }

  ## Set data class back to original
  if (!is_data_table) {class(final_data) <- data_class}
  ## Set return object
  return(final_data)
}
