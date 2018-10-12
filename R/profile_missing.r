#' Profile missing values
#'
#' Analyze missing value profile
#' @param data input data
#' @keywords profile_missing
#' @return missing value profile, such as frequency, percentage and suggested action.
#' @import data.table
#' @export profile_missing
#' @seealso \link{plot_missing}
#' @examples
#' profile_missing(airquality)

profile_missing <- function(data) {
	## Declare variable first to pass R CMD check
	feature <- num_missing <- pct_missing <- group <- NULL
	## Check if input is data.table
	is_data_table <- is.data.table(data)
	## Detect input data class
	data_class <- class(data)
	## Set data to data.table
	if (!is_data_table) data <- data.table(data)
	## Extract missing value distribution
	missing_value <- data.table(
		"feature" = names(data),
		"num_missing" = sapply(data, function(x) {sum(is.na(x))})
	)
	missing_value[, feature := factor(feature, levels = feature[order(-rank(num_missing))])]
	missing_value[, pct_missing := num_missing / nrow(data)]
	missing_value[pct_missing < 0.05, group := "Good"]
	missing_value[pct_missing >= 0.05 & pct_missing < 0.4, group := "OK"]
	missing_value[pct_missing >= 0.4 & pct_missing < 0.8, group := "Bad"]
	missing_value[pct_missing >= 0.8, group := "Remove"][]
	## Set data class back to original
	if (!is_data_table) class(missing_value) <- data_class

	missing_value
}
