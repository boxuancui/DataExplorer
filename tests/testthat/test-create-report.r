context("create report")
dir_name <- getwd()
file_name <- "testthat-report.html"
file_dir <- file.path(dir_name, file_name)

test_that("test if quiet is working for create_report", {
	skip_on_cran()
	expect_silent(create_report(iris, output_file = file_name, output_dir = dir_name, quiet = TRUE))
	expect_message(tmp <- capture.output(create_report(iris, output_file = file_name, output_dir = dir_name, quiet = FALSE)))
	expect_message(tmp <- capture.output(create_report(iris, output_file = file_name, output_dir = dir_name)))
	if (file.exists(file_dir)) file.remove(file_dir)
})

test_that("test overall functionalities", {
	skip_on_cran()
	create_report(iris, output_file = file_name, output_dir = dir_name, y = "Species", quiet = TRUE)
	create_report(iris, output_file = file_name, output_dir = dir_name, y = "Sepal.Length", quiet = TRUE)
	create_report(iris, output_file = file_name, output_dir = dir_name, config = list("introduce" = list(), "plot_prcomp" = list()), quiet = TRUE)
	create_report(iris, output_file = file_name, output_dir = dir_name, y = "Species", config = list("introduce" = list(), "plot_prcomp" = list()), quiet = TRUE)
	if (file.exists(file_dir)) file.remove(file_dir)
})

test_that("test if report is generated", {
	skip_on_cran()
	create_report(iris, output_file = file_name, output_dir = dir_name, quiet = TRUE)
	expect_true(file.exists(file_dir))
	expect_gte(file.info(file_dir)$size, 100000)
	if (file.exists(file_dir)) file.remove(file_dir)
})

test_that("test if non-existing y throws an error", {
	skip_on_cran()
	expect_error(create_report(iris, y = "abc"))
})

test_that("test if 0 complete rows are detected", {
	skip_on_cran()
	create_report(
		data.frame("a" = seq.int(5L), "b" = rep(NA, 5L)),
		config = list("plot_correlation" = list(), "plot_prcomp" = list())
	)
})
