#' Truncate category
#'
#' Output index and name for features that will be ignored
#' @param dt input data object.
#' @param maxcat maximum categories allowed for each discrete feature.
#' @return a named vector containing indices of features to be ignored.
#' @import data.table
.ignoreCat <- function(dt, maxcat) {
	if (!is.data.table(dt)) dt <- data.table(dt)
	n_cat <- sapply(dt, function(x) {
		length(unique(x))
	})
	n_cat[which(n_cat > maxcat)]
}

#' Get all missing columns
#'
#' Get number of columns with all values missing
#' @param dt input data object.
#' @return a named logical vector indicating if a column has only missing values.
#' @import data.table
.getAllMissing <- function(dt) {
	if (!is.data.table(dt)) dt <- data.table(dt)
	sapply(dt, function(x) {
		sum(is.na(x)) == length(x)
	})
}

#' Calculate page layout index
#'
#' Calculate column index on each page based on row and column counts
#' @param nrow number of rows per page
#' @param ncol number of columns per page
#' @param n number of features
#' @return a list containing column indices for each page
.getPageLayout <- function(nrow, ncol, n) {
	pp <- nrow * ncol
	pages <- ceiling(n / pp)
	lapply(setNames(seq.int(pages), paste("Page", seq.int(pages))), function(pg) {
		seq.int(from = pp * (pg - 1L) + 1L, to = min(n, pp * pg))
	})
}
