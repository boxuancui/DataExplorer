#' Split data into discrete and continuous parts
#'
#' This function splits the input data into two \link{data.table} objects: discrete and continuous. A feature is continuous if \code{is.numeric} returns \code{TRUE}.
#' @param data input data
#' @param binary_as_factor treat binary as categorical? Default is \code{FALSE}.
#' @keywords split_columns
#' @details Features with all missing values will be dropped from the output data, but will be counted towards the column count.
#' @details The elements in the output list will have the same class as the input data.
#' @return \code{discrete} all discrete features
#' @return \code{continous} all continuous features
#' @return \code{num_discrete} number of discrete features
#' @return \code{num_continuous} number of continuous features
#' @return \code{num_all_missing} number of features with no observations (all values are missing)
#' @import data.table
#' @export
#' @examples
#' output <- split_columns(iris)
#' output$discrete
#' output$continuous
#' output$num_discrete
#' output$num_continuous
#' output$num_all_missing

split_columns <- function(data, binary_as_factor = FALSE) {
  ## Check if input is data.table
  is_data_table <- is.data.table(data)
  ## Detect input data class
  data_class <- class(data)
  ## Set data to data.table
  if (!is_data_table) data <- data.table(data)
  ## Find indicies for each feature type
  all_missing_ind <- which(.getAllMissing(data))
  if (binary_as_factor) {
    binary_ind <- which(vapply(data, function(x) {length(unique(x)) == 2L}, TRUE))
    numeric_ind <- setdiff(which(vapply(data, is.numeric, TRUE)), c(all_missing_ind, binary_ind))
    discrete_ind <- setdiff(c(which(vapply(data, function(x) !is.numeric(x), TRUE)), binary_ind), all_missing_ind)
  } else {
    numeric_ind <- setdiff(which(vapply(data, is.numeric, TRUE)), all_missing_ind)
    discrete_ind <- setdiff(which(vapply(data, function(x) !is.numeric(x), TRUE)), all_missing_ind)
  }
  ## Count number of discrete, continuous and all-missing features
  n_all_missing <- length(all_missing_ind)
  n_continuous <- length(numeric_ind)
  n_discrete <- length(discrete_ind)
  ## Create object for continuous features
  continuous <- data[, numeric_ind, with = FALSE]
  setnames(continuous, make.names(names(continuous)))
  ## Create object for discrete features
  discrete <- data[, discrete_ind, with = FALSE]
  setnames(discrete, make.names(names(discrete)))
  ## Set data class back to original
  if (!is_data_table) class(discrete) <- class(continuous) <- data_class
  ## Set return object
  return(
    list(
      "discrete" = discrete,
      "continuous" = continuous,
      "num_discrete" = n_discrete,
      "num_continuous" = n_continuous,
      "num_all_missing" = n_all_missing
    )
  )
}
