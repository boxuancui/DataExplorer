#' Create scatterplot for all features
#'
#' This function creates scatterplot for all features fixing on a selected feature.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @param by feature name to be fixed.
#' @param title plot title
#' @param \dots other arguments to be passed to \link{geom_point}.
#' @keywords plot_scatterplot
#' @import data.table
#' @import ggplot2
#' @importFrom scales comma
#' @export plot_scatterplot
#' @seealso \link{geom_point}
#' @examples
#' # load mpg data from ggplot2
#' data("mpg", package = "ggplot2")
#'
#' # scatterplot mpg dataset by "hwy"
#' plot_scatterplot(mpg, "hwy", size = 1)
#' # scatterplot mpg dataset by "class"
#' plot_scatterplot(mpg, "class", size = 1)

plot_scatterplot <- function(data, by, title = NULL, ...) {
  ## Declare variable first to pass R CMD check
  variable <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) {data <- data.table(data)}
  ## Create plot function
  scatterplot <- function(input_data, ...) {
    dt <- suppressWarnings(melt.data.table(input_data, id.vars = by))
    ## Calculate number of pages
    p <- ncol(input_data) - 1
    pages <- ceiling(p / 9L)
    ## Create ggplot object
    for (pg in seq.int(pages)) {
      col_names <- setdiff(names(input_data), by)[seq.int(9L * pg - 8L, min(p, 9L * pg))]
      n_col <- ifelse(length(col_names) %% 3L, length(col_names) %/% 3L + 1L, length(col_names) %/% 3L)
      plot <- ggplot(dt[variable %in% col_names], aes_string(x = by, y = "value")) +
        geom_point(...) +
        facet_wrap(~ variable, ncol = n_col, scales = "free_x", shrink = FALSE) +
        coord_flip() +
        xlab(by) + ggtitle(title) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
      print(plot)
    }
  }
  ## Call plot function
  split_obj <- split_columns(data[, -by, with = FALSE])
  if (split_obj$num_continuous > 0) {
    plot_dt <- data.table(split_obj$continuous, "by_f" = data[[by]])
    setnames(plot_dt, "by_f", by)
    scatterplot(plot_dt, ...)
  }
  if (split_obj$num_discrete > 0) {
    plot_dt <- data.table(split_obj$discrete, "by_f" = data[[by]])
    setnames(plot_dt, "by_f", by)
    scatterplot(plot_dt, ...)
  }
}
