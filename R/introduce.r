#' Describe basic information
#'
#' Describe basic information for input data.
#' @param data input data.
#' @keywords introduce
#' @return Describe basic information in a \link{data.frame}.
#' @import data.table
#' @importFrom utils object.size
#' @export introduce
#' @examples
#' introduce(mtcars)

introduce <- function(data) {
  split_data <- split_columns(data)
  data.frame(
    "rows" = nrow(data),
    "columns" = ncol(data),
    "discrete_columns" = split_data[["num_discrete"]],
    "continuous_columns" = split_data[["num_continuous"]],
    "all_missing_columns" = split_data[["num_all_missing"]],
    "total_missing_values" = sum(is.na(data)),
    "total_observations" = nrow(data) * ncol(data),
    "size" = format(object.size(data), units = "auto")
  )
}
