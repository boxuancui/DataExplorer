#' Drop selected variables
#'
#' Quickly drop variables by either name or column position.
#' @param data input data, in \link{data.table} format only.
#' @param ind a vector of either names or column positions of the variables to be dropped.
#' @keywords dropvar
#' @details \bold{This function will only work with \link{data.table} object as input.} Consider setting your input to \link{data.table} first then assign the original class back after applying the function.
#' @import data.table
#' @export
#' @examples
#' # load packages
#' library(data.table)
#'
#' # generate data
#' dt <- data.table(sapply(setNames(letters, letters), function(x) {assign(x, rnorm(100))}))
#' dt2 <- copy(dt)
#'
#' # drop variables by name
#' names(dt)
#' DropVar(dt, letters[2:25])
#' names(dt)
#'
#' # drop variables by column position
#' names(dt2)
#' DropVar(dt2, seq(2, 25))
#' names(dt2)
#'
#' # work with non-data.table objects
#' iris_df <- data.table(iris)
#' DropVar(iris_df, "Species")
#' class(iris_df) <- "data.frame"

DropVar <- function(data, ind) {
  if (!is.data.table(data)) stop("Please change your input data class to data.table!")
  if (is.character(ind)) {
    data[, ind := NULL, with = FALSE]
  } else {
    data[, names(data)[ind] := NULL, with = FALSE]
  }
}
