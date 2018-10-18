#' Plot missing value profile
#'
#' This function returns and plots frequency of missing values for each feature.
#' @param data input data
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @return invisibly return the ggplot object
#' @keywords plot_missing
#' @import ggplot2
#' @export
#' @seealso \link{profile_missing}
#' @examples
#' plot_missing(airquality)

plot_missing <- function(data, title = NULL, ggtheme = theme_gray(), theme_config = list("legend.position" = c("bottom"))) {
	## Declare variable first to pass R CMD check
	pct_missing <- NULL
	## Profile missing values
	missing_value <- profile_missing(data)
	## Create ggplot object
	output <- ggplot(missing_value, aes_string(x = "feature", y = "num_missing", fill = "group")) +
		geom_bar(stat = "identity") +
		geom_text(aes(label = paste0(round(100 * pct_missing, 2), "%"))) +
		scale_fill_manual("Group", values = c("Good" = "#1a9641", "OK" = "#a6d96a", "Bad" = "#fdae61", "Remove" = "#d7191c"), breaks = c("Good", "OK", "Bad", "Remove")) +
		coord_flip() +
		xlab("Features") + ylab("Missing Rows")
	## Plot object
	class(output) <- c("single", class(output))
	plotDataExplorer(
		plot_obj = output,
		title = title,
		ggtheme = ggtheme,
		theme_config = theme_config
	)
}
