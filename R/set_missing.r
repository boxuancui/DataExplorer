#' Set all missing values to indicated value
#'
#' Quickly set all missing values to indicated value.
#' @param data input data, in \link{data.table} format only.
#' @param value a single value or a list of two values to be set to. See 'Details'.
#' @keywords set_missing
#' @aliases SetNaTo
#' @details \bold{This function will only work with \link{data.table} object as input.} Consider setting your input to \link{data.table} first then assign the original class back after applying the function.
#' @details The class of \code{value} will determine what type of columns to be set, e.g., if \code{value} is 0, then missing values for continuous features will be set. When supplying a list of two values, only one numeric and one non-numeric is allowed.
#' @import data.table
#' @export set_missing SetNaTo
#' @examples
#' # Load packages
#' library(data.table)
#'
#' # Generate missing values in iris data
#' dt <- data.table(iris)
#' for (j in 1:4) set(dt, i = sample.int(150, j * 30), j, value = NA_integer_)
#' set(dt, i = sample.int(150, 25), 5L, value = NA_character_)
#'
#' # Set all missing values to 0L and unknown
#' dt2 <- copy(dt)
#' set_missing(dt2, list(0L, "unknown"))
#'
#' # Set missing numerical values to 0L
#' dt3 <- copy(dt)
#' set_missing(dt3, 0L)
#'
#' # Set missing discrete values to unknown
#' dt4 <- copy(dt)
#' set_missing(dt4, "unknown")

set_missing <- function(data, value) {
  if (!is.data.table(data)) stop("Please change your input data class to data.table!")
  if (!(length(value) %in% seq(2))) stop("Please specify one single value or a list of two values!")

  if (length(value) == 1) {
    if (is.numeric(value)) {
      col_ind <- which(sapply(data, is.numeric))
    } else {
      col_ind <- which(!sapply(data, is.numeric))
    }
    for (j in col_ind) {
      num_missing <- sum(is.na(data[[j]]))
      set(data, i = which(is.na(data[[j]])), j = j, value = value)
      if (num_missing > 0) message(paste0("Column [", names(data)[j], "]: Set ", num_missing, " missing values to ", value))
    }
  } else {
    if (!is.list(value)) stop("Value must be a list of two!")
    val_ind <- sapply(value, is.numeric)
    if (val_ind[1] == val_ind[2]) stop("Please set one numerical value!")
    val_c <- value[[which(val_ind)]]
    val_d <- value[[which(!val_ind)]]
    col_c <- which(sapply(data, is.numeric))
    col_d <- which(!sapply(data, is.numeric))
    for (j in col_c) {
      num_missing <- sum(is.na(data[[j]]))
      set(data, i = which(is.na(data[[j]])), j = j, value = val_c)
      if (num_missing > 0) message(paste0("Column [", names(data)[j], "]: Set ", num_missing, " missing values to ", val_c))
    }
    for (j in col_d) {
      num_missing <- sum(is.na(data[[j]]))
      set(data, i = which(is.na(data[[j]])), j = j, value = val_d)
      if (num_missing > 0) message(paste0("Column [", names(data)[j], "]: Set ", num_missing, " missing values to ", val_d))
    }
  }
}

SetNaTo <- function(data, value) {
  .Deprecated("set_missing")
  set_missing(data = data, value = value)
}
