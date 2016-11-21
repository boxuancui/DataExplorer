context("generate report")

test_that("test if report is generated", {
  skip_on_cran()
  dir_name <- getwd()
  file_name <- "testthat-report.html"
  file_dir <- file.path(dir_name, file_name)
  GenerateReport(iris, output_file = file_name, output_dir = dir_name, quiet = TRUE)
  expect_true(file.exists(file_dir))
  expect_gte(file.info(file_dir)$size, 100000)
  if (file.exists(file_dir)) file.remove(file_dir)
})
