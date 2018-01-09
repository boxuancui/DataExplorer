#' Visualize data structure
#'
#' Visualize data structures in D3 network graph
#' @param data input data
#' @param type type of network diagram. Defaults to \link{diagonalNetwork}.
#' @param max_level integer threshold of nested level to be visualized. Minimum 1 nested level and defaults to all.
#' @param print_network logical indicating if network graph should be plotted. Defaults to \code{TRUE}.
#' @param \dots other arguments to be passed to plotting functions. See \link{diagonalNetwork} and \link{radialNetwork}.
#' @keywords plot_str
#' @aliases PlotStr
#' @return input data structure in nested list. Could be transformed to json format with most JSON packages.
#' @import data.table
#' @importFrom networkD3 diagonalNetwork radialNetwork
#' @importFrom utils capture.output str
#' @export plot_str PlotStr
#' @seealso \link{str}
#' @examples
#' \dontrun{
#' ## Visualize structure of iris dataset
#' plot_str(iris)
#'
#' ## Visualize object with radial network
#' plot_str(rep(list(rep(list(mtcars), 6)), 4), type = "r")
#'
#' ## Generate complicated data object
#' obj <- list(
#'   "a" = list(iris, airquality, list(mtcars = mtcars, USArrests = USArrests)),
#'   "b" = list(list(ts(1:10, frequency = 4))),
#'   "c" = lm(rnorm(5) ~ seq(5)),
#'   "d" = lapply(1:5, function(x) return(as.function(function(y) y + 1)))
#' )
#' ## Visualize data object with diagnal network
#' plot_str(obj, type = "d")
#' ## Visualize only top 2 nested levels
#' plot_str(obj, type = "d", max_level = 2)
#' }

plot_str <- function(data, type = c("diagonal", "radial"), max_level, print_network = TRUE, ...) {
  ## Declare variable first to pass R CMD check
  i <- idx <- parent <- NULL
  ## Capture str output
  str_output <- capture.output(str(data, vec.len = 0, give.attr = FALSE, give.length = FALSE))
  n <- length(str_output)
  ## Split to calculate nested levels
  base_split <- tstrsplit(str_output[2:n], "\\$")
  nest_level <- (nchar(base_split[[1]]) - nchar(gsub("\ \\.{2}", "", base_split[[1]]))) / 3 + 1
  ## Handle max_level if exists
  if (missing(max_level)) {
    max_level <- max(nest_level)
  } else if (max_level <= 0 | max_level > max(nest_level)) {
    stop(paste0("max_level should be between 1 and ", max(nest_level)))
  } else {
    max_level <- max_level
  }
  ## Split to retrieve level components
  comp_split <- tstrsplit(base_split[[2]], ":")
  ## Make sure the root of each component has a unique name
  comp_root <- gsub(" ", "", comp_split[[1]])
  comp_root[which(comp_root == "")] <- make.names(comp_root[which(comp_root == "")], unique = TRUE)
  ## Combine component name with type
  comp_output <- paste0(comp_root, " (", trimws(gsub("NULL|\\.{3}|\\.{2}", "", comp_split[[2]])), ")")
  ## Transform data to table format
  ## Reference: http://stackoverflow.com/q/41157332/2158269
  str_dt <- data.table(idx = seq_along(nest_level), nest_level, parent = comp_output)[nest_level <= max_level]
  str_dt <- str_dt[str_dt[, list(i = idx, nest_level = nest_level - 1, child = parent)], on = list(nest_level, idx < i), mult = "last"]
  drop_columns(str_dt[is.na(parent), parent := paste0("root (", str_output[1], ")")], c("idx", "nest_level"))
  ## Create recursive function to transform the table to nested list
  ## Reference: http://stackoverflow.com/a/23839564/2158269
  str_to_list <- function(str_dt, root_name = as.character(str_dt[["parent"]][1])) {
    str_list <- list(name = root_name)
    children <- str_dt[parent == root_name][["child"]]
    if(length(children) > 0) {
      str_list[["children"]] <- lapply(children, str_to_list, str_dt = str_dt)
    }
    str_list
  }
  ## Transform table to list
  str_list <- str_to_list(str_dt)
  ## Plot if print_network is TRUE
  if (print_network) {
    type <- match.arg(type)
    if (type == "diagonal") print(diagonalNetwork(str_list, ...))
    if (type == "radial") print(radialNetwork(str_list, ...))
  }
  ## Set return object in invisible mode
  return(invisible(str_list))
}

PlotStr <- function(data, type = c("diagonal", "radial"), max_level, print_network = TRUE, ...) {
  .Deprecated("plot_str")
  plot_str(data = data, type = type, max_level = max_level, print_network = print_network, ...)
}
