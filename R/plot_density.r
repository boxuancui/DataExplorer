#' Plot density estimates
#'
#' Plot density estimates for each continuous feature
#' @param data input data
#' @param binary_as_factor treat binary as categorical? Default is \code{TRUE}.
#' @param geom_density_args a list of other arguments to \link{geom_density}
#' @param scale_x scale of x axis. See \link{scale_x_continuous} for all options. Default is \code{continuous}.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page. Default is 4.
#' @param ncol number of columns per page. Default is 4.
#' @param parallel enable parallel? Default is \code{FALSE}.
#' @param ... aesthetic mappings (e.g., fill = Species, alpha = 0.5)
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_density
#' @import data.table
#' @import ggplot2
#' @importFrom utils modifyList
#' @export
#' @seealso \link{geom_density} \link{plot_histogram}
#' @examples
#' # Plot iris data
#' plot_density(iris, ncol = 2L)
#'
#' # Add color to density area
#' plot_density(iris, geom_density_args = list("fill" = "black", "alpha" = 0.6), ncol = 2L)
#' 
#' # Plot skewed data on log scale
#' set.seed(1)
#' skew <- data.frame(replicate(4L, rbeta(1000, 1, 5000)))
#' plot_density(skew, ncol = 2L)
#' plot_density(skew, scale_x = "log10", ncol = 2L)

plot_density <- function(data, binary_as_factor = TRUE,
                         geom_density_args = list(),
                         scale_x = "continuous",
                         title = NULL,
                         ggtheme = theme_gray(), theme_config = list(),
                         nrow = 4L, ncol = 4L,
                         parallel = FALSE,
                         ...) {
  # Ensure this works when data is a vector, like the vignette
  if (!is.data.frame(data)) {
    data <- data.frame(value = data)
  }
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
  
  ## Replicate other columns so mapped aesthetics work
  other_vars <- setdiff(names(data), names(dt))
  if (length(other_vars) > 0) {
    dt <- cbind(
      dt,
      data[rep(seq_len(nrow(data)), times = length(feature_names)), ..other_vars]
    )
  }
  
  ## Calculate number of pages
  layout <- .getPageLayout(nrow, ncol, ncol(continuous))
  ## Create ggplot object
  plot_list <- .lapply(
    parallel = parallel,
    X = layout,
    FUN = function(x) {
      dots_list <- rlang::enquos(...)
      flags <- vapply(dots_list, rlang::quo_is_symbolic, logical(1))
      mapped_aes <- dots_list[flags]
      constant_aes <- dots_list[!flags]
      
      aes_combined <- modifyList(aes(x = value), rlang::eval_tidy(rlang::expr(aes(!!!mapped_aes))))
      layer_args <- c(list(na.rm = TRUE), geom_density_args, lapply(constant_aes, rlang::eval_tidy))
      
      ggplot(dt[variable %in% feature_names[x]], mapping = aes_combined) +
        do.call("geom_density", layer_args) +
        do.call(paste0("scale_x_", scale_x), list()) +
        ylab("Density")
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
