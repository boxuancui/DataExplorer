#' Describe basic information
#'
#' Describe basic information for input data.
#' @param data input data.
#' @keywords introduce
#' @return Describe basic information in a \link{data.frame}:
#' \itemize{
#'   \item{rows: number of rows}
#'   \item{columns: number of columns}
#'   \item{discrete_columns: number of discrete columns}
#'   \item{continuous_columns: number of continuous columns}
#'   \item{all_missing_columns: number of columns with everything missing}
#'   \item{total_missing_values: number of missing observations}
#'   \item{total_observations: total number of observations}
#'   \item{memory_usage: estimated memory allocation in bytes. See \link{object.size}}
#' }
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
    "memory_usage" = as.numeric(object.size(data))
  )
}
