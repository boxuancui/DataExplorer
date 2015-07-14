#' GenerateReport Function
#'
#' This function generates the report of data profiling.
#' @param input_data data source to be profiled, in either \link{data.frame} or \link{data.table} format.
#' @param output_file output file name. The default is "report.html".
#' @param output_dir output directory for report. The default is user's current directory.
#' @param \dots other arguments to be passed to \link{render}.
#' @keywords generatereport
#' @import rmarkdown
#' @export
#' @examples
#' # load library
#' library(rmarkdown)
#' library(ggplot2)
#' library(data.table)
#'
#' # generate report for diamonds dataset
#' data(diamonds)
#' GenerateReport(diamonds,
#'                output_file="report.html",
#'                output_dir=getwd(),
#'                html_document(toc=TRUE, theme="flatly"))
#'
#' # generate report for
#' data <- read.csv("http://www.cftc.gov/dea/newcot/deacit.txt", header=FALSE)[, -c(2:3, 32)]
#' GenerateReport(data)

GenerateReport <- function(input_data, output_file="report.html", output_dir=getwd(), ...) {
  # get directory of report markdown template
  report_dir <- system.file("rmd_template/report.rmd", package="exploreR")
  # render report into html
  render(input=report_dir,
         output_file=output_file,
         output_dir=output_dir,
         params=list(data=input_data, fun_options=list()),
         ...)
  # open report
  browseURL(file.path(output_dir, output_file))
}
