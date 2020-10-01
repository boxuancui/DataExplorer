#' Describe basic information
#'
#' Describe basic information for input data.
#' @param data input data
#' @param add_percent if True an additional column with % of total is returned
#' @keywords introduce
#' @return Describe basic information in input data class:
#' \itemize{
#'   \item{discrete_columns: number of discrete columns}
#'   \item{continuous_columns: number of continuous columns}
#'   \item{all_missing_columns: number of columns with everything missing}
#'   \item{columns: number of columns}
#'   \item{complete_rows: number of rows without missing values. See \link{complete.cases}.}
#'   \item{rows: number of rows}
#'   \item{total_missing_values: number of missing observations}
#'   \item{infinite_values: number of Inf/-Inf observations}
#'   \item{nan_values: number of NaN observations}
#'   \item{total_observations: total number of observations}
#'   \item{memory_usage: estimated memory allocation in bytes. See \link{object.size}.}
#' }
#' @import data.table
#' @importFrom stats complete.cases
#' @importFrom utils object.size
#' @export introduce
#' @examples
#' introduce(mtcars)

introduce <- function(data, add_percent = F) {
	## Check and set to data.table
	is_data_table <- is.data.table(data)
	data_class <- class(data)
	if (!is.data.table(data)) data <- data.table(data)

	split_data <- split_columns(data)

	output <- data.table(
		"discrete_columns" = split_data[["num_discrete"]],
		"continuous_columns" = split_data[["num_continuous"]],
		"all_missing_columns" = split_data[["num_all_missing"]],
		"columns" = ncol(data),
		"complete_rows" = sum(complete.cases(data)),
		"rows" = nrow(data),
		"total_missing_values" = sum(is.na(data)),
		"infinite_values" = sum(is.infinite(as.numeric(unlist(data)))),
		"nan_values" = sum(is.nan(as.numeric(unlist(data)))),
		"total_observations" = nrow(data) * ncol(data),
		"memory_usage" = as.numeric(object.size(data))
	)
	
	if(add_percent){
	  output <- as.data.frame(t(output))
	  names(output) <- c('Count')
	  output['discrete_columns', '% of total'] <- round(output['discrete_columns', 'Count']/output['columns', 'Count']*100, 2)
	  output['continuous_columns', '% of total'] <- round(output['continuous_columns', 'Count']/output['columns', 'Count']*100, 2)
	  output['all_missing_columns', '% of total'] <- round(output['all_missing_columns', 'Count']/output['columns', 'Count']*100, 2)
	  output['complete_rows', '% of total'] <- round(output['complete_rows', 'Count']/output['rows', 'Count']*100, 2)
	  output['total_missing_values', '% of total'] <- round(output['total_missing_values', 'Count']/output['total_observations', 'Count']*100, 2)
	  output['infinite_values', '% of total'] <- round(output['infinite_values', 'Count']/output['total_observations', 'Count']*100, 2)
	  output['nan_values', '% of total'] <- round(output['nan_values', 'Count']/output['total_observations', 'Count']*100, 2)
	  output
	} else {
	  ## Set data class back to original
	  if (!is_data_table) class(output) <- data_class
	  output
	}
}
