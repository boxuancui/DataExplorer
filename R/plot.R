#' Default DataExplorer plotting function
#'
#' S3 method for plotting various DataExplorer objects
#' @param plot_obj plot object
#' @param title plot title
#' @param ggtheme complete ggplot2 themes
#' @param theme_config a list of configurations to be passed to \link[ggplot2]{theme}
#' @param \dots other arguments to be passed
#' @return invisibly return the named list of ggplot objects
#' @keywords internal
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @export
#' @seealso \link{plotDataExplorer.grid} \link{plotDataExplorer.single} \link{plotDataExplorer.multiple}
#' @examples
#' library(ggplot2)
#' # Update theme of any plot objects
#' plot_missing(airquality, ggtheme = theme_light())
#' plot_missing(airquality, ggtheme = theme_minimal(base_size = 20))
#'
#' # Customized theme components
#' plot_bar(
#'   data = diamonds,
#'   theme_config = list(
#'   "plot.background" = element_rect(fill = "yellow"),
#'   "aspect.ratio" = 1
#'   )
#' )
plotDataExplorer <- function(plot_obj, title, ggtheme, theme_config, ...) {
  UseMethod("plotDataExplorer")
}

#' Plot objects with gridExtra
#'
#' Plot multiple DataExplorer objects using grid.arrange
#' @param plot_obj list of ggplot objects
#' @param title plot title
#' @param ggtheme complete ggplot2 themes
#' @param theme_config a list of configurations to be passed to \link[ggplot2]{theme}
#' @param page_layout a list of page indices with associated plot indices
#' @param nrow number of rows per page
#' @param ncol number of columns per page
#' @param \dots other arguments to be passed
#' @return invisibly return the named list of ggplot objects
#' @keywords internal
#' @method plotDataExplorer grid
#' @import ggplot2
#' @import gridExtra
#' @export
#' @seealso \link{plotDataExplorer} \link{plotDataExplorer.single} \link{plotDataExplorer.multiple}
plotDataExplorer.grid <- function(plot_obj, title, ggtheme, theme_config, page_layout, nrow, ncol, ...) {
  plot_list <- lapply(plot_obj, function(p) {
    p +
      eval(ggtheme) +
      do.call(theme, theme_config)
  })
  
  if (length(page_layout) > 1) {
    invisible(lapply(names(page_layout), function(pg_name) {
      index <- page_layout[[pg_name]]
      suppressMessages(do.call(grid.arrange, c(plot_list[index], ncol = ncol, nrow = nrow, top = title, bottom = pg_name)))
    }))
  } else {
    suppressMessages(do.call(grid.arrange, c(plot_list, ncol = ncol, nrow = nrow, top = title)))
  }
  
  invisible(plot_list)
}

#' Plot single object
#'
#' Plot single DataExplorer object
#' @param plot_obj single ggplot object
#' @param title plot title
#' @param ggtheme complete ggplot2 themes
#' @param theme_config a list of configurations to be passed to \link[ggplot2]{theme}
#' @param \dots other arguments to be passed
#' @return invisibly return the ggplot object
#' @keywords internal
#' @method plotDataExplorer single
#' @import ggplot2
#' @export
#' @seealso \link{plotDataExplorer} \link{plotDataExplorer.grid} \link{plotDataExplorer.multiple}
plotDataExplorer.single <- function(plot_obj, title, ggtheme, theme_config, ...) {
  plot_obj <- plot_obj +
    ggtitle(title) +
    eval(ggtheme) +
    do.call(theme, theme_config)
  
  print(plot_obj)
  invisible(plot_obj)
}

#' Plot multiple objects
#'
#' Plot multiple DataExplorer objects with the defined layout
#' @param plot_obj list of ggplot objects separated by page
#' @param page_layout a list of page indices with associated plot indices
#' @param facet_wrap_args a list of other arguments to \link[ggplot2]{facet_wrap}
#' @param title plot title
#' @param ggtheme complete ggplot2 themes
#' @param theme_config a list of configurations to be passed to \link[ggplot2]{theme}
#' @param \dots other arguments to be passed
#' @return invisibly return the named list of ggplot objects
#' @keywords internal
#' @method plotDataExplorer multiple
#' @import ggplot2
#' @importFrom stats setNames
#' @export
#' @seealso \link{plotDataExplorer} \link{plotDataExplorer.grid} \link{plotDataExplorer.single}
plotDataExplorer.multiple <- function(plot_obj, title, ggtheme, theme_config, page_layout, facet_wrap_args = list(), ...) {
  n <- length(page_layout)
  plot_list <- lapply(setNames(seq.int(n), paste0("page_", seq.int(n))), function(i) {
    plot_obj[[i]] +
      do.call("facet_wrap", facet_wrap_args) +
      labs(title = title, caption = ifelse(n > 1, names(page_layout)[i], "")) +
      ggtitle(title) +
      eval(ggtheme) +
      do.call(theme, theme_config)
  })
  
  invisible(capture.output(print(plot_list)))
  invisible(plot_list)
}
