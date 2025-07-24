context("create report")
dir_name <- getwd()
file_name <- "testthat-report.html"
file_dir <- file.path(dir_name, file_name)

test_that("test overall functionalities", {
  skip_on_cran()
  create_report(iris, output_file = file_name, output_dir = dir_name, y = "Species",
                report_title = "1/5: Set y as Species", quiet = TRUE)
  create_report(iris, output_file = file_name, output_dir = dir_name, y = "Sepal.Length",
                report_title = "2/5: Set y as Sepal.Length", quiet = TRUE)
  create_report(iris, output_file = file_name, output_dir = dir_name,
                config = list("introduce" = list(), "plot_prcomp" = list()),
                report_title = "3/5: `introduce` & `plot_prcomp`", quiet = TRUE)
  create_report(iris, output_file = file_name, output_dir = dir_name, y = "Species",
                config = list("plot_bar" = list("with" = "Sepal.Length"), "plot_prcomp" = list()),
                report_title = "4/5: Set y as Species; `plot_bar` with Sepal.Length; `plot_prcomp`",
                quiet = TRUE)
  create_report(data.frame("a" = seq.int(5L), "b" = rep(NA, 5L)),
                output_file = file_name, output_dir = dir_name,
                config = list("plot_correlation" = list(), "plot_prcomp" = list()),
                report_title = "5/5: Detect 0 complete rows", quiet = TRUE)
  create_report(iris, output_file = file_name, output_dir = dir_name, quiet = TRUE)
  expect_true(file.exists(file_dir))
  expect_gte(file.info(file_dir)$size, 100000)
  if (file.exists(file_dir)) expect_true(file.remove(file_dir))
})

test_that("test if non-existing y throws an error", {
  skip_on_cran()
  expect_error(create_report(iris, y = "abc"))
  if (file.exists(file_dir)) file.remove(file_dir)
})

if (file.exists(file_dir)) file.remove(file_dir)
