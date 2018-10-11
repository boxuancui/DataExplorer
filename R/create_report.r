#' create_report Function
#'
#' This function creates a data profiling report.
#' @param data input data
#' @param output_file output file name. The default is "report.html".
#' @param output_dir output directory for report. The default is user's current directory.
#' @param y name of response variable if any. Response variables will be passed to appropriate plotting functions automatically.
#' @param config report configuration with function arguments as \link{list}. See details.
#' @param \dots other arguments to be passed to \link{render}.
#' @keywords create_report
#' @details \code{config} is a named list to be evaluated by \code{create_report}.
#' Each name should exactly match a function name.
#' By doing so, that function and corresponding content will be added to the report.
#' If you do not want to include certain functions/content, do not add it to \code{config}.
#' @details By default, there is a preset \code{config} object (refer to example).
#' In case you would like to customize the report, copy and edit the code and pass it to \code{config} argument.
#' @details All function arguments will be passed to \link{do.call} as a list.
#' @note If both \code{y} and \code{plot_prcomp} are present, \code{y} will be removed from \code{plot_prcomp}.
#' @note If there are multiple options for the same function, all of them will be plotted.
#' For example, \code{create_report(..., y = "a", config = list("plot_bar" = list("with" = "b")))} will create 3 bar charts:
#' \itemize{
#' \item regular frequency bar chart
#' \item bar chart aggregated by response variable "a"
#' \item bar chart aggregated by `with` variable "b"`
#' }
#' @importFrom utils browseURL
#' @importFrom rmarkdown render
#' @export create_report
#' @examples
#' \dontrun{
#' #############################
#' ## Default config file     ##
#' ## Copy and edit if needed ##
#' #############################
#' config <- list(
#'   "introduce" = list(),
#'   "plot_str" = list(
#'     "type" = "diagonal",
#'     "fontSize" = 35,
#'     "width" = 1000,
#'     "margin" = list("left" = 350, "right" = 250)
#'   ),
#'   "plot_missing" = list(),
#'   "plot_histogram" = list(),
#'   "plot_bar" = list(),
#'   "plot_correlation" = list("use" = "pairwise.complete.obs"),
#'   "plot_prcomp" = list(),
#'   "plot_boxplot" = list(),
#'   "plot_scatterplot" = list()
#' )
#'
#' # Create report
#' create_report(iris)
#' create_report(airquality, y = "Ozone")
#'
#' # Load library
#' library(ggplot2)
#' library(data.table)
#' data("diamonds", package = "ggplot2")
#'
#' # Set some missing values
#' diamonds2 <- data.table(diamonds)
#' for (j in 5:ncol(diamonds2)) {
#'   set(diamonds2,
#'       i = sample.int(nrow(diamonds2), sample.int(nrow(diamonds2), 1)),
#'       j,
#'       value = NA_integer_)
#' }
#'
#' # Create customized report for diamonds2 dataset
#' create_report(
#'   data = diamonds2,
#'   output_file = "report.html",
#'   output_dir = getwd(),
#'   y = "price",
#'   config = list(
#'     "introduce" = list(),
#'     "plot_missing" = list(),
#'     "plot_histogram" = list(),
#'     "plot_density" = list(),
#'     "plot_bar" = list("with" = "carat"),
#'     "plot_correlation" = list("use" = "pairwise.complete.obs"),
#'     "plot_prcomp" = list(),
#'     "plot_boxplot" = list("by" = "carat"),
#'     "plot_scatterplot" = list("by" = "carat")
#'   ),
#'   html_document(toc = TRUE, toc_depth = 6, theme = "flatly")
#' )
#' }

create_report <- function(data, output_file = "report.html", output_dir = getwd(), y = NULL, config = list(), ...) {
	## Check if input is data.table
	if (!is.data.table(data)) data <- data.table(data)
	## Check response variable
	if (!is.null(y)) {
		if (!(y %in% names(data))) stop("`", y, "` not found in data!")
	}
	## Get directory of report markdown template
	report_dir <- system.file("rmd_template/report.rmd", package = "DataExplorer")
	## Set report configuration if null
	if (length(config) == 0) {
		config <- list(
			"introduce" = list(),
			"plot_str" = list("type" = "diagonal", "fontSize" = 35, "width" = 1000, "margin" = list("left" = 350, "right" = 250)),
			"plot_missing" = list(),
			"plot_histogram" = list(),
			"plot_bar" = list(),
			"plot_correlation" = list("use" = "pairwise.complete.obs"),
			"plot_prcomp" = list(),
			"plot_boxplot" = list(),
			"plot_scatterplot" = list()
		)
	}
	## Render report into html
	suppressWarnings(render(
		input = report_dir,
		output_file = output_file,
		output_dir = output_dir,
		intermediates_dir = output_dir,
		params = list(data = data, report_config = config, response = y),
		...
	))
	## Open report
	report_path <- file.path(output_dir, output_file)
	browseURL(report_path)
	## Print report directory
	args <- as.list(match.call())
	if (ifelse(is.null(args[["quiet"]]), TRUE, !args[["quiet"]])) message(paste0("\n\nReport is generated at \"", report_path, "\"."))
}
