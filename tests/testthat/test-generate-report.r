context("generate report")

test_that("test if report is generated", {
  dir_name <- dirname(system.file("tests/testthat/test-generate-report.r", package = "DataExplorer"))
  file_name <- "testthat-report.html"
  file_dir <- file.path(dir_name, file_name)
  GenerateReport(iris, output_file = file_name, output_dir = dir_name)
  expect_true(file.exists(file_dir))
  expect_gte(file.info(file_dir)$size, 1700000)
})
