#' Create scatterplot for all features
#'
#' This function creates scatterplot for all features fixing on a selected feature.
#' @param data input data
#' @param by feature name to be fixed.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param \dots other arguments to be passed to \link{geom_point}.
#' @keywords plot_scatterplot
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @import data.table
#' @import ggplot2
#' @importFrom scales comma
#' @export plot_scatterplot
#' @seealso \link{geom_point}
#' @examples
#' # Load mpg data from ggplot2
#' data("mpg", package = "ggplot2")
#'
#' # Scatterplot mpg dataset by "hwy"
#' plot_scatterplot(mpg, "hwy", size = 1)
#'
#' # Scatterplot mpg dataset by "class"
#' plot_scatterplot(mpg, "class", size = 1)
#'
#' # Scatterplot with preset ggplot2 themes
#' library(ggplot2)
#' plot_scatterplot(mpg, "hwy", ggtheme = theme_light())
#'
#' # Scatterplot with customized theme components
#' plot_scatterplot(mpg, "hwy", theme_config = list("axis.text.x" = element_text(angle = 90)))

plot_scatterplot <- function(data, by, title = NULL, ggtheme = theme_gray(), theme_config = list("axis.text.x" = element_text(angle = 45, hjust = 1)), ...) {
  ## Declare variable first to pass R CMD check
  variable <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) data <- data.table(data)
  ## Create plot function
  scatterplot <- function(input_data, col_type, ...) {
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
        labs(x = by, title = title, caption = ifelse(pages > 1, paste0(col_type, ": Page ", pg), col_type)) +
        ggtheme +
        do.call(theme, theme_config)
      print(plot)
    }
  }
  ## Call plot function
  split_obj <- split_columns(data[, -by, with = FALSE])
  if (split_obj$num_continuous > 0) {
    plot_dt <- data.table(split_obj$continuous, "by_f" = data[[by]])
    setnames(plot_dt, "by_f", by)
    scatterplot(plot_dt, col_type = "Continuous Features", ...)
  }
  if (split_obj$num_discrete > 0) {
    plot_dt <- data.table(split_obj$discrete, "by_f" = data[[by]])
    setnames(plot_dt, "by_f", by)
    scatterplot(plot_dt, col_type = "Discrete Features", ...)
  }
}
