#' Create boxplot for continuous features
#'
#' This function creates boxplot for each continuous feature based on a selected feature.
#' @param data input data
#' @param by feature name to be broken down by. If selecting a continuous feature, boxplot will be grouped by 5 equal ranges, otherwise, all existing categories for a discrete feature.
#' @param binary_as_factor treat binary as categorical? Default is \code{TRUE}.
#' @param geom_boxplot_args a list of other arguments to \link{geom_boxplot}
#' @param geom_jitter_args a list of other arguments to \link{geom_jitter}. If empty, \link{geom_jitter} will not be added.
#' @param scale_y scale of original y axis (before \code{coord_flip}). See \link{scale_y_continuous} for all options. Default is \code{continuous}.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page
#' @param ncol number of columns per page
#' @param parallel enable parallel? Default is \code{FALSE}.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_boxplot
#' @import data.table
#' @import ggplot2
#' @export
#' @seealso \link{geom_boxplot}
#' @examples
#' plot_boxplot(iris, by = "Species", ncol = 2L)
#' plot_boxplot(iris, by = "Species", geom_boxplot_args = list("outlier.color" = "red"))
#' 
#' # Plot skewed data on log scale
#' set.seed(1)
#' skew <- data.frame(y = rep(c("a", "b"), 500), replicate(4L, rbeta(1000, 1, 5000)))
#' plot_boxplot(skew, by = "y", ncol = 2L)
#' plot_boxplot(skew, by = "y", scale_y = "log10", ncol = 2L)
#' 
#' # Plot with `geom_jitter`
#' plot_boxplot(iris, by = "Species", ncol = 2L, geom_jitter_args = list(width = NULL)) # Turn on with default settings

plot_boxplot <- function(data, by,
                         binary_as_factor = TRUE,
                         geom_boxplot_args = list(),
                         geom_jitter_args = list(),
                         scale_y = "continuous",
                         title = NULL,
                         ggtheme = theme_gray(), theme_config = list(),
                         nrow = 3L, ncol = 4L,
                         parallel = FALSE) {
  ## Declare variable first to pass R CMD check
  variable <- by_f <- value <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) data <- data.table(data)
  ## Stop if no continuous features
  split_obj <- split_columns(data, binary_as_factor = binary_as_factor)
  if (split_obj$num_continuous == 0) stop("No Continuous Features!")
  ## Get continuous features
  continuous <- split_obj$continuous
  ## Check feature to be broken down
  by_feature <- data[[by]]
  if (is.null(by_feature)) stop(paste0("Feature \"", by, "\" not found!"))
  if (is.numeric(by_feature)) {
    dt <- suppressWarnings(melt.data.table(data.table(continuous, "by_f" = cut_interval(by_feature, 5)), id.vars = "by_f", variable.factor = FALSE))
  } else {
    dt <- suppressWarnings(melt.data.table(data.table(continuous, "by_f" = by_feature), id.vars = "by_f", variable.factor = FALSE))
  }
  dt2 <- dt[variable != by]
  feature_names <- unique(dt2[["variable"]])
  ## Calculate number of pages
  layout <- .getPageLayout(nrow, ncol, length(feature_names))
  ## Create list of ggplot objects
  plot_list <- .lapply(
    parallel = parallel,
    X = layout,
    FUN = function(x) {
      base_plot <- ggplot(dt2[variable %in% feature_names[x]], aes(x = by_f, y = value)) +
        do.call("geom_boxplot", geom_boxplot_args) +
        do.call(paste0("scale_y_", scale_y), list()) +
        coord_flip() +
        xlab(by)
      if (!identical(geom_jitter_args, list())) base_plot <- base_plot + do.call("geom_jitter", geom_jitter_args)
      base_plot
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
      "scales" = "free_x"
    )
  )
}
