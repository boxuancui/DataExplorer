#' Split data into discrete and continuous
#'
#' This function splits the input data into two \link{data.table} objects: discrete and continuous. A feature is continuous if \code{is.numeric} returns \code{TRUE}.
#' @param data input data to be split, in either \link{data.frame} or \link{data.table} format.
#' @keywords splitcoltype
#' @details Features with all missing values will be dropped from the output data, but will be counted towards the column count.
#' @return \code{discrete} all discrete features in \link{data.table} format
#' @return \code{continous} all continuous features in \link{data.table} format
#' @return \code{num_discrete} number of discrete features
#' @return \code{num_continuous} number of continuous features
#' @import data.table
#' @export
#' @examples
#' output <- SplitColType(iris)
#' output$discrete
#' output$continuous
#' output$num_discrete
#' output$num_continuous
#' output$num_all_missing

SplitColType <- function(data) {
  if (!is.data.table(data)) {data <- data.table(data)}
  # find indicies for continuous features
  ind <- sapply(data, is.numeric)
  all_missing_ind <- sapply(data, function(x) {sum(is.na(x)) == length(x)})
  # number of discrete, continuous and all-missing features
  n_all_missing <- sum(all_missing_ind)
  n_continuous <- sum(ind)
  n_discrete <- ncol(data) - n_continuous - n_all_missing
  # create object for continuous features
  continuous <- data[, which(ind), with = FALSE]
  # create object for discrete features
  discrete <- data[, which(!(ind | all_missing_ind)), with = FALSE]
  return(list("discrete" = discrete, "continuous" = continuous, "num_discrete" = n_discrete, "num_continuous" = n_continuous, "num_all_missing" = n_all_missing))
}
