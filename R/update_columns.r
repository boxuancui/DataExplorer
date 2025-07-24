#' Update variable types or values
#'
#' Quickly update selected variables using column names or positions.
#' @param data input data
#' @param ind a vector of either names or column positions of the variables to be dropped.
#' @param what either a function or a non-empty character string naming the function to be called. See \link[base]{do.call}.
#' @keywords drop_columns
#' @details \bold{This function updates \link[data.table]{data.table} object directly.} Otherwise, output data will be returned matching input object class.
#' @import data.table
#' @export
#' @examples
#' str(update_columns(iris, 1L, as.factor))
#' str(update_columns(iris, c("Sepal.Width", "Petal.Length"), "as.integer"))
#' 
#' ## Apply log transformation to all columns
#' summary(airquality)
#' summary(update_columns(airquality, names(airquality), log))
#' 
#' ## Force set factor to numeric
#' df <- data.frame("a" = as.factor(sample.int(10L)))
#' str(df)
#' str(update_columns(df, "a", function(x) as.numeric(levels(x))[x]))

update_columns <- function(data, ind, what) {
  ## Check if input is data.table
  is_data_table <- is.data.table(data)
  ## Detect input data class
  data_class <- class(data)
  ## Set data to data.table
  if (!is_data_table) data <- data.table(data)
  ## Transform columns
  if (is.numeric(ind)) ind <- as.integer(ind)
  for (j in ind) set(x = data, j = j, value = do.call(what, list(data[[j]])))
  ## Set data class back to original
  if (!is_data_table) {
    class(data) <- data_class
    return(data)
  }
}
