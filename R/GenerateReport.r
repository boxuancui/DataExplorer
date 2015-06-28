## generate data profiling report
GenerateReport <- function(input_data, ...) {
  render(input="report.rmd",
         html_document(toc=TRUE, theme="readable"),
         params=list(data=input_data),
         ...)
  browseURL("report.html")
}