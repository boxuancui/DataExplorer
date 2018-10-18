#' Drop selected variables
#'
#' Quickly drop variables by either name or column position.
#' @param data input data
#' @param ind a vector of either names or column positions of the variables to be dropped.
#' @keywords drop_columns
#' @details \bold{This function updates \link{data.table} object directly.} Otherwise, output data will be returned matching input object class.
#' @import data.table
#' @export drop_columns
#' @examples
#' # Load packages
#' library(data.table)
#'
#' # Generate data
#' dt <- data.table(sapply(setNames(letters, letters), function(x) {assign(x, rnorm(10))}))
#' dt2 <- copy(dt)
#'
#' # Drop variables by name
#' names(dt)
#' drop_columns(dt, letters[2L:25L])
#' names(dt)
#'
#' # Drop variables by column position
#' names(dt2)
#' drop_columns(dt2, seq(2, 25))
#' names(dt2)
#'
#' # Return from non-data.table input
#' df <- data.frame(sapply(setNames(letters, letters), function(x) {assign(x, rnorm(10))}))
#' drop_columns(df, letters[2L:25L])

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
