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
#' # scatterplot mpg dataset by "hwy"
#' data("mpg", package = "ggplot2")
#' plot_scatterplot(mpg[, 1:10], "hwy", size = 1)

plot_scatterplot <- function(data, by, title = NULL, ...) {
  ## Declare variable first to pass R CMD check
  variable <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) {data <- data.table(data)}
  dt <- suppressWarnings(melt.data.table(data, id.vars = by))
  ## Calculate number of pages
  p <- ncol(data) - 1
  pages <- ceiling(p / 9L)
  ## Create ggplot object
  for (pg in seq.int(pages)) {
    col_names <- setdiff(names(data), by)[seq.int(9L * pg - 8L, min(p, 9L * pg))]
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
