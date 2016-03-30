#' GenerateReport Function
#'
#' This function generates the report of data profiling.
#' @param input_data data source to be profiled, in either \link{data.frame} or \link{data.table} format.
#' @param output_file output file name. The default is "report.html".
#' @param output_dir output directory for report. The default is user's current directory.
#' @param \dots other arguments to be passed to \link{render}.
#' @keywords generatereport
#' @import rmarkdown
#' @importFrom utils browseURL
#' @export
#' @examples
#' \dontrun{
#' # load library
#' library(rmarkdown)
#' library(ggplot2)
#' library(data.table)
#'
#' # load data
#' data(diamonds)
#' diamonds2 <- data.table(diamonds)
#'
#' # manually set some missing values
#' for (j in 5:ncol(diamonds2)) {
#'   set(diamonds2,
#'       i = sample.int(nrow(diamonds2), sample.int(nrow(diamonds2), 1)),
#'       j,
#'       value = NA_integer_)}
#'
#' # generate report for diamonds dataset
#' GenerateReport(diamonds2,
#'                output_file = "report.html",
#'                output_dir = getwd(),
#'                html_document(toc = TRUE, toc_depth = 6, theme = "flatly"))
#' }

GenerateReport <- function(input_data, output_file = "report.html", output_dir = getwd(), ...) {
  # get directory of report markdown template
  report_dir <- system.file("rmd_template/report.rmd", package = "DataExplorer")
  # render report into html
  render(input = report_dir,
         output_file = output_file,
         output_dir = output_dir,
         intermediates_dir = output_dir,
         params=list(data = input_data, fun_options = list()),
         ...)
  # open report
  report_path <- file.path(output_dir, output_file)
  browseURL(report_path)
  # print report directory
  cat(paste0("\n\nReport is generated at \"", report_path, "\"."))
}
