#' Split data into discrete and continuous
#'
#' This function splits the input data into two \link{data.table} objects: discrete and continuous. A feature is continuous if \code{is.numeric} returns \code{TRUE}.
#' @param data input data to be split, in either \link{data.frame} or \link{data.table} format.
#' @keywords splitcoltype
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

SplitColType <- function(data) {
  if (!is.data.table(data)) {data <- data.table(data)}
  # find indicies for continuous features
  ind <- sapply(data, is.numeric)
  # number of discrete vs. continuous features
  n_continuous <- sum(ind)
  n_discrete <- ncol(data) - n_continuous
  # create object for continuous features
  continuous <- data[, which(ind), with = FALSE]
  # create object for discrete features
  discrete <- data[, which(!ind), with = FALSE]
  return(list("discrete" = discrete, "continuous" = continuous, "num_discrete" = n_discrete, "num_continuous" = n_continuous))
}
