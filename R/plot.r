#' Plot objects with gridExtra
#'
#' Plot multiple DataExplorer objects with the defined layout
#' @param obj_list list of ggplot objects
#' @param page_layout output of \link{.getPageLayout}
#' @param nrow number of rows per page
#' @param ncol number of columns per page
#' @param title plot title
#' @param ggtheme complete ggplot2 themes
#' @param theme_config a list of configurations to be passed to \link{theme}
#' @return invisibly return the named list of ggplot objects
#' @import ggplot2
#' @import gridExtra
plot.DataExplorerGrid <- function(obj_list, page_layout, nrow, ncol, title, ggtheme, theme_config) {
	plot_list <- lapply(obj_list, function(p) {
		p +
			ggtheme +
			do.call(theme, theme_config)
	})

	if (length(page_layout) > 1) {
		invisible(lapply(names(page_layout), function(pg_name) {
			index <- page_layout[[pg_name]]
			do.call(grid.arrange, c(plot_list[index], ncol = ncol, nrow = nrow, top = title, bottom = pg_name))
		}))
	} else {
		do.call(grid.arrange, c(plot_list, top = title))
	}

	invisible(plot_list)
}
