#' Create scatterplot for all features
#'
#' This function creates scatterplot for all features fixing on a selected feature.
#' @param data input data
#' @param by feature name to be fixed at
#' @param sampled_rows number of rows to sample if data has too many rows. Default is all rows, which means do not sample.
#' @param geom_point_args a list of other arguments to \link{geom_point}
#' @param scale_x scale of x axis. See \link{scale_x_continuous} for all options. Default is \code{continuous}.
#' @param scale_y scale of y axis. See \link{scale_y_continuous} for all options. Default is \code{continuous}.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page
#' @param ncol number of columns per page
#' @param parallel enable parallel? Default is \code{FALSE}.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_scatterplot
#' @import data.table
#' @import ggplot2
#' @export
#' @seealso \link{geom_point}
#' @examples
#' plot_scatterplot(iris, by = "Species")
#'
#' # Customize themes
#' library(ggplot2)
#' plot_scatterplot(
#'   data = mpg,
#'   by = "hwy",
#'   geom_point_args = list(size = 1L),
#'   theme_config = list("axis.text.x" = element_text(angle = 90)),
#'   ncol = 4L
#' )
#' 
#' # Plot skewed data on log scale
#' set.seed(1)
#' skew <- data.frame(replicate(5L, rbeta(1000, 1, 5000)))
#' plot_scatterplot(skew, by = "X5", ncol = 2L)
#' plot_scatterplot(skew, by = "X5", scale_x = "log10", scale_y = "log10", ncol = 2L)

plot_scatterplot <- function(data, by, sampled_rows = nrow(data),
                             geom_point_args = list(),
                             scale_x = "continuous",
                             scale_y = "continuous",
                             title = NULL,
                             ggtheme = theme_gray(), theme_config = list(),
                             nrow = 3L, ncol = 3L,
                             parallel = FALSE) {
  ## Declare variable first to pass R CMD check
  variable <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) data <- data.table(data)
  ## Sample data if necessary
  if (sampled_rows < nrow(data)) data <- data[sample.int(nrow(data), sampled_rows)]
  ## Create plot function
  dt <- suppressWarnings(melt.data.table(data, id.vars = by, variable.factor = FALSE))
  feature_names <- unique(dt[["variable"]])
  ## Calculate number of pages
  layout <- .getPageLayout(nrow, ncol, length(feature_names))
  ## Create list of ggplot objects
  plot_list <- .lapply(
    parallel = parallel,
    X = layout,
    FUN = function(x) {
      ggplot(dt[variable %in% feature_names[x]], aes_string(x = by, y = "value")) +
        do.call("geom_point", geom_point_args) +
        do.call(paste0("scale_x_", scale_x), list()) +
        do.call(paste0("scale_y_", scale_y), list()) +
        coord_flip() +
        xlab(by)
    }
  )
  ## Plot objects
  class(plot_list) <- c("multiple", class(plot_list))
  plotDataExplorer(
    plot_obj = plot_list,
    page_layout = layout,
    title = title,
    ggtheme = ggtheme,
    theme_config = theme_config,
    facet_wrap_args = list(
      "facet" = ~ variable,
      "nrow" = nrow,
      "ncol" = ncol,
      "scales" = "free_x",
      "shrink" = FALSE
    )
  )
}
