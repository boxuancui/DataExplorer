#' Set missing numerical values to an indicated value
#'
#' Quickly set all missing numerical values to an indicated value.
#' @param data input data, in \link{data.table} format only.
#' @param value the value to be set to.
#' @keywords setnato
#' @details \bold{This function will only work with \link{data.table} object as input.} Consider setting your input to \link{data.table} first then assign the original class back after applying the function.
#' @import data.table
#' @export
#' @examples
#' # load packages
#' library(data.table)
#'
#' # generate missing values in iris data
#' dt <- data.table(iris)
#' for (j in 1:4) set(dt, i = sample.int(150, j * 30), j, value = NA_integer_)
#'
#' # set all missing values to 0
#' SetNaTo(dt, 0)

SetNaTo <- function(data, value) {
  if (!is.data.table(data)) stop("Please change your input data class to data.table!")
  for (j in seq_along(data)) {
    set(data, i = which(is.na(data[[j]])), j = j, value = value)
  }
}
