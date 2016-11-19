context("generate report")

test_that("test if report is generated", {
  output_path <- file.path("tests", "testthat")
  file_name <- "testthat_report.html"
  file_dir <- file.path(output_path, file_name)
  if (file.exists(file_dir)) file.remove(file_dir)
  GenerateReport(iris, output_file = file_name, output_dir = output_path)
  expect_true(file.exists(file.path(output_path, file_name)))
  expect_gte(file.info(file_dir)$size, 1700000)
})
