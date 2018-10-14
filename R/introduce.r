#' Describe basic information
#'
#' Describe basic information for input data.
#' @param data input data
#' @keywords introduce
#' @return Describe basic information in input data class:
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
	## Check and set to data.table
	is_data_table <- is.data.table(data)
	data_class <- class(data)
	if (!is.data.table(data)) data <- data.table(data)

	split_data <- split_columns(data)

	output <- data.table(
		"rows" = nrow(data),
		"columns" = ncol(data),
		"discrete_columns" = split_data[["num_discrete"]],
		"continuous_columns" = split_data[["num_continuous"]],
		"all_missing_columns" = split_data[["num_all_missing"]],
		"total_missing_values" = sum(is.na(data)),
		"total_observations" = nrow(data) * ncol(data),
		"memory_usage" = as.numeric(object.size(data))
	)

	## Set data class back to original
	if (!is_data_table) class(output) <- data_class
	output
}
