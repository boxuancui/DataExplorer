#' Plot density estimates
#'
#' Plot density estimates for each continuous feature
#' @param data input data
#' @param by feature name to be broken down by. If \code{NULL}, no grouping. If a continuous feature, values are grouped into 5 equal ranges; otherwise all categories of a discrete feature are used.
#' @param binary_as_factor treat binary as categorical? Default is \code{TRUE}.
#' @param geom_density_args a list of other arguments to \link[ggplot2]{geom_density}
#' @param scale_x scale of x axis. See \link[ggplot2]{scale_x_continuous} for all options. Default is \code{continuous}.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link[ggplot2]{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link[ggplot2]{theme}.
#' @param nrow number of rows per page. Default is 4.
#' @param ncol number of columns per page. Default is 4.
#' @param parallel enable parallel? Default is \code{FALSE}.
#' @param plotly if \code{TRUE}, convert to interactive plotly object (requires the \pkg{plotly} package). Default is \code{FALSE}.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_density
#' @import data.table
#' @import ggplot2
#' @export
#' @seealso \link[ggplot2]{geom_density} \link{plot_histogram}
#' @examples
#' # Plot iris data
#' plot_density(iris, ncol = 2L)
#'
#' # Plot density by a discrete feature
#' plot_density(iris, by = "Species", ncol = 2L)
#'
#' # Add color to density area
#' plot_density(iris, geom_density_args = list("fill" = "black", "alpha" = 0.6), ncol = 2L)
#' 
#' # Plot skewed data on log scale
#' set.seed(1)
#' skew <- data.frame(replicate(4L, rbeta(1000, 1, 5000)))
#' plot_density(skew, ncol = 2L)
#' plot_density(skew, scale_x = "log10", ncol = 2L)

plot_density <- function(data, by = NULL, binary_as_factor = TRUE,
                         geom_density_args = list(),
                         scale_x = "continuous",
                         title = NULL,
                         ggtheme = theme_gray(), theme_config = list(),
                         nrow = 4L, ncol = 4L,
                         parallel = FALSE, plotly = FALSE) {
  ## Declare variable first to pass R CMD check
  variable <- value <- by_f <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) data <- data.table(data)
  ## Stop if no continuous features
  split_data <- split_columns(data, binary_as_factor = binary_as_factor)
  if (split_data$num_continuous == 0) stop("No continuous features found!")
  ## Get continuous features
  continuous <- split_data$continuous
  feature_names <- names(continuous)
  if (is.null(by)) {
    dt <- suppressWarnings(melt.data.table(continuous, measure.vars = feature_names, variable.factor = FALSE))
    dt2 <- dt
  } else {
    by_feature <- data[[by]]
    if (is.null(by_feature)) stop(paste0("Feature \"", by, "\" not found!"))
    if (is.numeric(by_feature)) {
      dt <- suppressWarnings(melt.data.table(data.table(continuous, "by_f" = cut_interval(by_feature, 5)), id.vars = "by_f", variable.factor = FALSE))
    } else {
      dt <- suppressWarnings(melt.data.table(data.table(continuous, "by_f" = by_feature), id.vars = "by_f", variable.factor = FALSE))
    }
    dt2 <- dt[variable != by]
    feature_names <- unique(dt2[["variable"]])
  }
  ## Calculate number of pages
  layout <- .getPageLayout(nrow, ncol, length(feature_names))
  ## Create ggplot object
  plot_list <- .lapply(
    parallel = parallel,
    X = layout,
    FUN = function(x) {
      if (is.null(by)) {
        p <- ggplot(dt2[variable %in% feature_names[x]], aes(x = .data[["value"]])) +
          do.call("geom_density", c("na.rm" = TRUE, geom_density_args)) +
          do.call(paste0("scale_x_", scale_x), list()) +
          ylab("Density")
      } else {
        p <- ggplot(dt2[variable %in% feature_names[x]], aes(x = .data[["value"]], color = .data[["by_f"]])) +
          do.call("geom_density", c("na.rm" = TRUE, geom_density_args)) +
          do.call(paste0("scale_x_", scale_x), list()) +
          ylab("Density") +
          labs(color = by)
      }
      p
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
    plotly = plotly,
    facet_wrap_args = list(
      "facet" = ~ variable,
      "nrow" = nrow,
      "ncol" = ncol,
      "scales" = "free"
    )
  )
}
