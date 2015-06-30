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
#' # generate data profiling report for iris dataset
#' library(rmarkdown)
#' GenerateReport(iris,
#'                output_file="report.html",
#'                output_dir=getwd(),
#'                html_document(toc=TRUE, theme="flatly"))
#' 
#' # generate data profiling report for transformed diamonds dataset
#' # load packages
#' library(ggplot2)
#' library(data.table)
#' # load diamonds dataset from ggplot2
#' data("diamonds")
#' # making more columns as factors
#' diamonds <- data.table(diamonds)
#' diamonds[, color_clarity:=as.factor(paste0(color, "_", clarity))]
#' diamonds[, cut_color:=as.factor(paste0(cut, "_", color))]
#' diamonds[, cut_clarity:=as.factor(paste0(cut, "_", clarity))]
#' diamonds[, color_clarity:=as.factor(paste0(color, "_", clarity))]
#' diamonds2 <- dcast.data.table(diamonds,
#'                               carat + cut + color + clarity + cut_color +
#'                               cut_clarity + color_clarity + depth + table +
#'                               x + y + z ~ color_clarity,
#'                               fun=sum,
#'                               value.var="price",
#'                               fill=NA)
#' for (col in names(diamonds2)[grep("D_|E_|F_", names(diamonds2))]) {
#'   set(diamonds2, j=col, value=as.factor(diamonds2[[col]]))
#' }
#' for (col in names(diamonds2)[grep("G_|H_|I_|J_", names(diamonds2))]) {
#'   set(diamonds2,
#'       i=sample(floor(runif(1) * nrow(diamonds2))),
#'       j=col,
#'       value=round(runif(1, max=20000)))
#' }
#' # generate report
#' GenerateReport(diamonds2)
#' 

GenerateReport <- function(input_data, output_file="report.html", output_dir=getwd(), ...) {
  # get directory of report markdown template
  report_dir <- system.file("rmd_template/report.rmd", package="exploreR")
  # render report into html
  render(input=report_dir,
         output_file=output_file,
         output_dir=output_dir,
         params=list(data=input_data),
         ...)
  # open report
  browseURL(file.path(output_dir, output_file))
}
