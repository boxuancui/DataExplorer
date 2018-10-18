#' Dummify discrete features to binary columns
#'
#' Data dummification is also known as one hot encoding or feature binarization. It turns each category to a distinct column with binary (numeric) values.
#' @param data input data
#' @param maxcat maximum categories allowed for each discrete feature. Default is 50.
#' @param select names of selected features to be dummified. Default is \code{NULL}.
#' @keywords dummify
#' @details Continuous features will be ignored if added in \code{select}.
#' @details \code{select} features will be ignored if categories exceed \code{maxcat}.
#' @note This is different from \link{model.matrix}, where the latter aims to create a full rank matrix for regression-like use cases. If your intention is to create a design matrix, use \link{model.matrix} instead.
#' @return dummified dataset (discrete features only) preserving original features. However, column order might be different.
#' @import data.table
#' @export
#' @examples
#' ## Dummify iris dataset
#' str(dummify(iris))
#'
#' ## Dummify diamonds dataset ignoring features with more than 5 categories
#' data("diamonds", package = "ggplot2")
#' str(dummify(diamonds, maxcat = 5))
#' str(dummify(diamonds, select = c("cut", "color")))

dummify <- function(data, maxcat = 50L, select = NULL) {
	## Declare variable first to pass R CMD check
	discrete_id <- NULL
	## Check if input is data.table
	is_data_table <- is.data.table(data)
	## Detect input data class
	data_class <- class(data)
	## Set data to data.table
	if (!is.data.table(data)) data <- data.table(data)
	## Split data
	split_data <- split_columns(data)
	continuous <- split_data$continuous
	## Check select in continuous features
	if (any(select %in% names(continuous))) {
		cont_ind <- which(names(continuous) %in% select)
		warning("Ignored the following continuous features in `select`:\n", paste0("\t* ", names(continuous)[cont_ind], "\n"))
		## Remove continuous names from select
		if (setequal(select, names(continuous)[cont_ind])) {
			select <- NULL
		} else {
			select <- setdiff(select, names(continuous)[cont_ind])
		}
	}

	if (split_data$num_discrete > 0) {
		discrete <- split_data$discrete
		## Count valid features
		ind <- .ignoreCat(discrete, maxcat)
		if (!is.null(select)) {
			## Remove maxcat names from select
			true_discrete_names <- setdiff(select, names(ind))
		} else {
			## Remove maxcat names from discrete
			true_discrete_names <- setdiff(names(discrete), names(ind))
		}
		n_true_discrete <- length(true_discrete_names)
		ignored_discrete_names <- setdiff(names(discrete), true_discrete_names)

		if (all(split_data$num_discrete, length(ind), !n_true_discrete)) {
			warning("Ignored all discrete features since `maxcat` set to ", maxcat, " categories!")
			final_data <- data
		} else {
			if (n_true_discrete > 0) {
				if (length(ind) > 0) {
					message(length(ind), " features with more than ", maxcat, " categories ignored!\n", paste0(names(ind), ": ", as.numeric(ind), " categories\n"))
				}
				## Set key for discrete features
				discrete[, discrete_id := .I]
				## Join ignored and valid discrete features based on key
				discrete_pivot <- Reduce(
					function(x, y) {merge(x, y, by = "discrete_id")},
					c(
						## Get ignored discrete features
						list(discrete[, c("discrete_id", ignored_discrete_names), with = FALSE]),
						## Pivot valid discrete features
						lapply(true_discrete_names, function(x) {
							dcast.data.table(discrete, discrete_id ~ make.names(paste0(x, "_", get(x))), length, value.var = "discrete_id")
						})
					)
				)
				drop_columns(discrete_pivot, "discrete_id")
				if (split_data$num_continuous == 0) {
					final_data <- discrete_pivot
				} else {
					final_data <- cbind(continuous, discrete_pivot)
				}
			}
		}
	} else {
		warning("No discrete features found! Nothing is dummified!")
		final_data <- continuous
	}

	## Set data class back to original
	if (!is_data_table) class(final_data) <- data_class
	final_data
}
