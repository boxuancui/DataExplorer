#' Plot histogram
#'
#' Plot histogram for each continuous feature
#' @param data input data
#' @param binary_as_factor treat binary as categorical? Default is \code{TRUE}.
#' @param geom_histogram_args a list of other arguments to \link{geom_histogram}
#' @param scale_x scale of x axis. See \link{scale_x_continuous} for all options. Default is \code{continuous}.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page. Default is 4.
#' @param ncol number of columns per page. Default is 4.
#' @param parallel enable parallel? Default is \code{FALSE}.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_histogram
#' @import data.table
#' @import ggplot2
#' @export
#' @seealso \link{geom_histogram} \link{plot_density}
#' @examples
#' # Plot iris data
#' plot_histogram(iris, ncol = 2L)
#'
#' # Plot random data
#' set.seed(1)
#' data <- data.frame(replicate(16L, rnorm(50)))
#' plot_histogram(data)
#' 
#' # Plot skewed data on log scale
#' set.seed(1)
#' skew <- data.frame(replicate(4L, rbeta(1000, 1, 5000)))
#' plot_histogram(skew, ncol = 2L)
#' plot_histogram(skew, scale_x = "log10", ncol = 2L)

plot_histogram <- function(data, binary_as_factor = TRUE,
                           geom_histogram_args = list("bins" = 30L),
                           scale_x = "continuous",
                           title = NULL,
                           ggtheme = theme_gray(), theme_config = list(),
                           nrow = 4L, ncol = 4L,
                           parallel = FALSE) {
  ## Declare variable first to pass R CMD check
  variable <- value <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) data <- data.table(data)
  ## Stop if no continuous features
  split_data <- split_columns(data, binary_as_factor = binary_as_factor)
  if (split_data$num_continuous == 0) stop("No continuous features found!")
  ## Get and reshape continuous features
  continuous <- split_data$continuous
  feature_names <- names(continuous)
  dt <- suppressWarnings(melt.data.table(continuous, measure.vars = feature_names, variable.factor = FALSE))
  ## Calculate number of pages
  layout <- .getPageLayout(nrow, ncol, ncol(continuous))
  ## Create ggplot object
  plot_list <- .lapply(
    parallel = parallel,
    X = layout,
    FUN = function(x) {
      ggplot(dt[variable %in% feature_names[x]], aes(x = value)) +
        do.call("geom_histogram", c("na.rm" = TRUE, geom_histogram_args)) +
        do.call(paste0("scale_x_", scale_x), list()) +
        ylab("Frequency")
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
      "scales" = "free"
    )
  )
}
