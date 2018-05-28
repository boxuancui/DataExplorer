#' Drop selected variables
#'
#' Quickly drop variables by either name or column position.
#' @param data input data
#' @param ind a vector of either names or column positions of the variables to be dropped.
#' @keywords drop_columns
#' @aliases DropVar
#' @details \bold{This function updates \link{data.table} object directly.} Otherwise, output data will be returned matching input object class.
#' @import data.table
#' @export drop_columns DropVar
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
#' drop_columns(dt, letters[2:25])
#' names(dt)
#'
#' # drop variables by column position
#' names(dt2)
#' drop_columns(dt2, seq(2, 25))
#' names(dt2)
#'
#' # work with non-data.table objects
#' iris_df <- data.table(iris)
#' drop_columns(iris_df, "Species")
#' class(iris_df) <- "data.frame"

drop_columns <- function(data, ind) {
  ## Check if input is data.table
  is_data_table <- is.data.table(data)
  ## Detect input data class
  data_class <- class(data)
  ## Set data to data.table
  if (!is_data_table) data <- data.table(data)
  ## Drop columns
  data[, (ind) := NULL]
  ## Set data class back to original
  if (!is_data_table) {
    class(data) <- data_class
    return(data)
  }
}

DropVar <- function(data, ind) {
  .Deprecated("drop_columns")
  drop_columns(data = data, ind = ind)
}
