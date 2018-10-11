#' Create boxplot for continuous features
#'
#' This function creates boxplot for each continuous feature based on a selected feature.
#' @param data input data
#' @param by feature name to be broken down by. If selecting a continuous feature, boxplot will be grouped by 5 equal ranges, otherwise, all existing categories for a discrete feature.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param \dots other arguments to be passed to \link{geom_boxplot}.
#' @keywords plot_boxplot
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @import data.table
#' @import ggplot2
#' @export plot_boxplot
#' @seealso \link{geom_boxplot}
#' @examples
#' # Plot iris dataset by "Species" (discrete)
#' plot_boxplot(iris, by = "Species")
#'
#' # Plot mtcars dataset by "mpg" (continuous)
#' plot_boxplot(mtcars, "mpg")
#'
#' # Plot with preset ggplot2 themes
#' library(ggplot2)
#' plot_boxplot(iris, by = "Species", ggtheme = theme_light())
#' plot_boxplot(iris, by = "Species", ggtheme = theme_minimal(base_size = 20))
#'
#' # Plot bar charts with customized theme components
#' plot_boxplot(iris,
#' by = "Species",
#' theme_config = list(
#'   "plot.background" = element_rect(fill = "yellow"),
#'   "aspect.ratio" = 1
#' ))

plot_boxplot <- function(data, by, title = NULL, ggtheme = theme_gray(), theme_config = list(), ...) {
  ## Declare variable first to pass R CMD check
  variable <- by_f <- value <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) data <- data.table(data)
  ## Stop if no continuous features
  split_obj <- split_columns(data)
  if (split_obj$num_continuous == 0) stop("No Continuous Features!")
  ## Get continuous features
  continuous <- split_obj$continuous
  ## Check feature to be broken down
  by_feature <- data[[by]]
  if (is.null(by_feature)) stop(paste0("Feature \"", by, "\" not found!"))
  if (is.numeric(by_feature)) {
    dt <- suppressWarnings(melt.data.table(data.table(continuous, "by_f" = cut_interval(by_feature, 5)), id.vars = "by_f"))
  } else {
    dt <- suppressWarnings(melt.data.table(data.table(continuous, "by_f" = by_feature), id.vars = "by_f"))
  }
  ## Calculate number of pages
  p <- ncol(continuous)
  pages <- ceiling(p / 12L)
  ## Create ggplot object
  for (pg in seq.int(pages)) {
    col_names <- names(continuous)[seq.int(12L * pg - 11L, min(p, 12L * pg))]
    n_col <- ifelse(length(col_names) %% 3L, length(col_names) %/% 3L + 1L, length(col_names) %/% 3L)
    plot <- ggplot(dt[variable %in% col_names], aes(x = by_f, y = value)) +
      geom_boxplot(...) +
      facet_wrap(~ variable, ncol = n_col, scales = "free_x") +
      coord_flip() +
      labs(x = by, title = title, caption = ifelse(pages > 1, paste("Page", pg), "")) +
      ggtheme +
      do.call(theme, theme_config)
    print(plot)
  }
}
