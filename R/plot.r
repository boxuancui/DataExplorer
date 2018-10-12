#' Default DataExplorer plotting function
#'
#' Plot various DataExplorer objects
#' @param \dots arguments to be passed
plotDataExplorer <- function(...) UseMethod("plotDataExplorer")

#' Plot objects with gridExtra
#'
#' Plot multiple DataExplorer objects using grid.arrange
#' @param obj_list list of ggplot objects
#' @param page_layout output of \link{.getPageLayout}
#' @param nrow number of rows per page
#' @param ncol number of columns per page
#' @param title plot title
#' @param ggtheme complete ggplot2 themes
#' @param theme_config a list of configurations to be passed to \link{theme}
#' @return invisibly return the named list of ggplot objects
#' @method plotDataExplorer grid
#' @import ggplot2
#' @import gridExtra
plotDataExplorer.grid <- function(obj_list, page_layout, nrow, ncol, title, ggtheme, theme_config) {
	plot_list <- lapply(obj_list, function(p) {
		p +
			ggtheme +
			do.call(theme, theme_config)
	})

	if (length(page_layout) > 1) {
		invisible(lapply(names(page_layout), function(pg_name) {
			index <- page_layout[[pg_name]]
			suppressMessages(do.call(grid.arrange, c(plot_list[index], ncol = ncol, nrow = nrow, top = title, bottom = pg_name)))
		}))
	} else {
		suppressMessages(do.call(grid.arrange, c(plot_list, top = title)))
	}

	invisible(plot_list)
}

#' Plot single object
#'
#' Plot single DataExplorer object
#' @param obj ggplot object
#' @param title plot title
#' @param ggtheme complete ggplot2 themes
#' @param theme_config a list of configurations to be passed to \link{theme}
#' @return invisibly return the ggplot object
#' @method plotDataExplorer single
#' @import ggplot2
plotDataExplorer.single <- function(obj, title, ggtheme, theme_config) {
	plot_obj <- obj +
		ggtitle(title) +
		ggtheme +
		do.call(theme, theme_config)

	print(plot_obj)
	invisible(plot_obj)
}

#' Plot multiple objects
#'
#' Plot multiple DataExplorer objects with the defined layout
#' @param obj_list list of ggplot objects
#' @param page_layout output of \link{.getPageLayout}
#' @param title plot title
#' @param ggtheme complete ggplot2 themes
#' @param theme_config a list of configurations to be passed to \link{theme}
#' @param \dots other arguments to be passed to \link{facet_wrap}.
#' @return invisibly return the named list of ggplot objects
#' @method plotDataExplorer multiple
#' @import ggplot2
#' @importFrom stats setNames
plotDataExplorer.multiple <- function(obj_list, page_layout, title, ggtheme, theme_config, ...) {
	n <- length(page_layout)
	plot_list <- lapply(setNames(seq.int(n), paste0("page_", seq.int(n))), function(i) {
		obj_list[[i]] +
			facet_wrap(...) +
			labs(title = title, caption = ifelse(n > 1, names(page_layout)[i], "")) +
			ggtitle(title) +
			ggtheme +
			do.call(theme, theme_config)
	})

	invisible(capture.output(print(plot_list)))
	invisible(plot_list)
}
