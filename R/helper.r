#' Truncate category
#'
#' Output index and name for features that will be ignored
#' @param data input data object.
#' @param maxcat maximum categories allowed for each discrete feature.
#' @return a named vector containing indices of features to be ignored.
#' @import data.table
.ignoreCat <- function(dt, maxcat) {
  if (!is.data.table(dt)) {
    dt <- data.table(dt)
  }
  n_cat <- sapply(dt, function(x) {
    length(unique(x))
  })
  n_cat[which(n_cat > maxcat)]
}
