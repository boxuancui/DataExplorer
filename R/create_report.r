#' create_report Function
#'
#' This function generates the report of data profiling.
#' @param data data source to be profiled, in either \link{data.frame} or \link{data.table} format.
#' @param output_file output file name. The default is "report.html".
#' @param output_dir output directory for report. The default is user's current directory.
#' @param \dots other arguments to be passed to \link{render}.
#' @keywords create_report
#' @aliases GenerateReport
#' @importFrom utils browseURL
#' @importFrom rmarkdown render
#' @export create_report GenerateReport
#' @examples
#' \dontrun{
#' # load library
#' library(ggplot2)
#' library(data.table)
#'
#' # load diamonds dataset from ggplot2
#' data("diamonds", package = "ggplot2")
#' diamonds2 <- data.table(diamonds)
#'
#' # manually set some missing values
#' for (j in 5:ncol(diamonds2)) {
#'   set(diamonds2,
#'       i = sample.int(nrow(diamonds2), sample.int(nrow(diamonds2), 1)),
#'       j,
#'       value = NA_integer_)}
#'
#' # generate report for diamonds2 dataset
#' create_report(diamonds2,
#'                output_file = "report.html",
#'                output_dir = getwd(),
#'                html_document(toc = TRUE, toc_depth = 6, theme = "flatly"))
#' }

create_report <- function(data, output_file = "report.html", output_dir = getwd(), ...) {
  ## Get argument list
  args <- as.list(match.call())
  ## Get directory of report markdown template
  report_dir <- system.file("rmd_template/report.rmd", package = "DataExplorer")
  ## Render report into html
  suppressWarnings(render(
    input = report_dir,
    output_file = output_file,
    output_dir = output_dir,
    intermediates_dir = output_dir,
    params = list(data = data, fun_options = list()),
    ...
  ))
  ## Open report
  report_path <- file.path(output_dir, output_file)
  browseURL(report_path)
  ## Print report directory
  if (ifelse(is.null(args[["quiet"]]), TRUE, !args[["quiet"]])) message(paste0("\n\nReport is generated at \"", report_path, "\"."))
}

GenerateReport <- function(data, output_file = "report.html", output_dir = getwd(), ...) {
  .Deprecated("create_report")
  create_report(data = data, output_file = output_file, output_dir = output_dir, ...)
}
