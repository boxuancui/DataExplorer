#' Configure report template
#'
#' This function configures the content of the to-be-generated data profiling report.
#' @param add_introduce add \link{introduce}? Default is \code{TRUE}.
#' @param add_plot_intro add \link{plot_intro}? Default is \code{TRUE}.
#' @param add_plot_str add \link{plot_str}? Default is \code{TRUE}.
#' @param add_plot_missing add \link{plot_missing}? Default is \code{TRUE}.
#' @param add_plot_histogram add \link{plot_histogram}? Default is \code{TRUE}.
#' @param add_plot_density add \link{plot_density}? Default is \code{FALSE}.
#' @param add_plot_qq add \link{plot_qq}? Default is \code{TRUE}.
#' @param add_plot_bar add \link{plot_bar}? Default is \code{TRUE}.
#' @param add_plot_correlation add \link{plot_correlation}? Default is \code{TRUE}.
#' @param add_plot_prcomp add \link{plot_prcomp}? Default is \code{TRUE}.
#' @param add_plot_boxplot add \link{plot_boxplot}? Default is \code{TRUE}.
#' @param add_plot_scatterplot add \link{plot_scatterplot}? Default is \code{TRUE}.
#' @param introduce_args arguments to be passed to \link{introduce}. Default is \code{list()}.
#' @param plot_intro_args arguments to be passed to \link{plot_intro}. Default is \code{list()}.
#' @param plot_str_args arguments to be passed to \link{plot_str}. Default is \code{list(type = "diagonal", fontSize = 35, width = 1000, margin = list(left = 350, right = 250))}.
#' @param plot_missing_args arguments to be passed to \link{plot_missing}. Default is \code{list()}.
#' @param plot_histogram_args arguments to be passed to \link{plot_histogram}. Default is \code{list()}.
#' @param plot_density_args arguments to be passed to \link{plot_density}. Default is \code{list()}.
#' @param plot_qq_args arguments to be passed to \link{plot_qq}. Default is \code{list(sampled_rows = 1000L)}.
#' @param plot_bar_args arguments to be passed to \link{plot_bar}. Default is \code{list()}.
#' @param plot_correlation_args arguments to be passed to \link{plot_correlation}. Default is \code{list("cor_args" = list("use" = "pairwise.complete.obs"))}.
#' @param plot_prcomp_args arguments to be passed to \link{plot_prcomp}. Default is \code{list()}.
#' @param plot_boxplot_args arguments to be passed to \link{plot_boxplot}. Default is \code{list()}.
#' @param plot_scatterplot_args arguments to be passed to \link{plot_scatterplot}. Default is \code{list(sampled_rows = 1000L)}.
#' @param global_ggtheme global setting for \link{theme}. Default is \code{quote(theme_gray())}.
#' @param global_theme_config global setting for \link{theme}. Default is \code{list()}.
#' @keywords configure_report
#' @note Individual settings will overwrite global settings. For example: if \code{plot_intro_args} has \code{ggtheme} set to \code{theme_light()} while \code{global_ggtheme} is set to \code{theme_gray()}, \code{theme_light()} will be used.
#' @note When setting global themes using \code{global_ggtheme}, please pass an unevaluated call to the theme function, e.g., \code{quote(theme_light())}.
#' @export
#' @seealso \link{create_report}
#' @examples
#' ## Get default configuration
#' configure_report()
#' 
#' ## Set global theme
#' configure_report(global_ggtheme = quote(theme_light(base_size = 20L)))

configure_report <- function(
  add_introduce = TRUE,
  add_plot_intro = TRUE,
  add_plot_str = TRUE,
  add_plot_missing = TRUE,
  add_plot_histogram = TRUE,
  add_plot_density = FALSE,
  add_plot_qq = TRUE, 
  add_plot_bar = TRUE,
  add_plot_correlation = TRUE,
  add_plot_prcomp = TRUE,
  add_plot_boxplot = TRUE,
  add_plot_scatterplot = TRUE,
  introduce_args = list(),
  plot_intro_args = list(),
  plot_str_args = list(type = "diagonal", fontSize = 35, width = 1000, margin = list(left = 350, right = 250)),
  plot_missing_args = list(),
  plot_histogram_args = list(),
  plot_density_args = list(),
  plot_qq_args = list(sampled_rows = 1000L),
  plot_bar_args = list(),
  plot_correlation_args = list("cor_args" = list("use" = "pairwise.complete.obs")),
  plot_prcomp_args = list(),
  plot_boxplot_args = list(),
  plot_scatterplot_args = list(sampled_rows = 1000L),
  global_ggtheme = quote(theme_gray()),
  global_theme_config = list()
) {
  ## Parse formal arguments
  input_args <- as.list(match.call())
  self_name <- input_args[[1]]
  formal_args <- formals(match.fun(self_name))
  switches <- grep("add_", names(formal_args), value = TRUE, fixed = TRUE)
  global_settings <- grep("global_", names(formal_args), value = TRUE, fixed = TRUE)
  global_exceptions <- c("add_introduce", "add_plot_str")
  ## Set config data based on arguments
  config <- lapply(setNames(switches, switches), function(s) {
    if ((!is.null(input_args[[s]]) && input_args[[s]]) || (is.null(input_args[[s]]) && formal_args[[s]])) {
      key_args <- paste0(gsub("add_", "", s, fixed = TRUE), "_args")
      input_values <- eval(input_args[[key_args]])
      formal_values <- eval(formal_args[[key_args]])
      value <- NULL
      if (!(s %in% global_exceptions)) {
        if ("ggtheme" %in% names(input_values)) {
          value <- list(ggtheme = input_values[["ggtheme"]])
          input_values[["ggtheme"]] <- NULL
        } else {
          value <- list(ggtheme = global_ggtheme)
        }
        if ("theme_config" %in% names(input_values)) {
          value <- c(value, list(theme_config = input_values[["theme_config"]]))
          input_values[["theme_config"]] <- NULL
        } else {
          value <- c(value, list(theme_config = global_theme_config))
        }
      }
      if (!is.null(input_values)) {
        value <- c(value, input_values)
      } else {
        value <- c(value, formal_values)
      }
    }
  })
  names(config) <- gsub("add_", "", names(config), fixed = TRUE)
  Filter(Negate(is.null), config)
}
