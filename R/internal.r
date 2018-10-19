#' Truncate category
#'
#' Output index and name for features that will be ignored
#' @param dt input data object.
#' @param maxcat maximum categories allowed for each discrete feature.
#' @return a named vector containing number of categories for to-be-ignored features.
#' @keywords internal
#' @import data.table
.ignoreCat <- function(dt, maxcat) {
	if (!is.data.table(dt)) dt <- data.table(dt)
	n_cat <- vapply(dt, function(x) {length(unique(x))}, 0)
	n_cat[which(n_cat > maxcat)]
}

#' Get all missing columns
#'
#' Get number of columns with all values missing
#' @param dt input data object.
#' @return a named logical vector indicating if a column has only missing values.
#' @keywords internal
#' @import data.table
.getAllMissing <- function(dt) {
	if (!is.data.table(dt)) dt <- data.table(dt)
	vapply(dt, function(x) sum(is.na(x)) == length(x), TRUE)
}

#' Calculate page layout index
#'
#' Calculate column index on each page based on row and column counts
#' @param nrow number of rows per page
#' @param ncol number of columns per page
#' @param n number of features
#' @return a list containing column indices for each page
#' @keywords internal
#' @importFrom stats setNames
.getPageLayout <- function(nrow, ncol, n) {
	pp <- nrow * ncol
	pages <- ceiling(n / pp)
	lapply(setNames(seq.int(pages), paste("Page", seq.int(pages))), function(pg) {
		seq.int(from = pp * (pg - 1L) + 1L, to = min(n, pp * pg))
	})
}

#' Parallelization
#'
#' Parallelize jobs based on condition
#' @param parallel enable parallel?
#' @param X a vector (atomic or list) or an expression object
#' @param FUN the function to be applied to each element of X
#' @return list of output from input
#' @keywords internal
#' @importFrom parallel detectCores
#' @importFrom parallel mclapply
.lapply <- function(parallel, X, FUN) {
	if (parallel) {
		mclapply(
			X = X,
			FUN = FUN,
			mc.preschedule = TRUE,
			mc.silent = TRUE,
			mc.cores = max(1L, detectCores() - 1L)
		)
	} else {
<<<<<<< HEAD
		chk <- Sys.getenv("_R_CHECK_LIMIT_CORES_", "")
		if (nzchar(chk) && chk == "TRUE") {
			2L
		} else {
			max(1L, detectCores() - 1L)
		}
=======
		lapply(X = X, FUN = FUN)
>>>>>>> master
	}
}
