context("plot data structure")
library(jsonlite)
library(methods)

test_that("test nested levels", {
  skip_on_cran()
  iris_output <- plot_str(iris, print_network = FALSE)
  expect_equal(length(iris_output), 2)
  obj <- list(list(list(list("a" = 1L))))
  obj_output <- plot_str(obj, print_network = FALSE)
  expect_equal(obj_output$children[[1]]$children[[1]]$children[[1]]$children[[1]]$name, "a (int)")
})

test_that("test returned object is valid json", {
  skip_on_cran()
  obj <- list(lm(rnorm(5) ~ letters[1:5]), list(iris), list(list(list("a" = 1L))))
  obj_output <- plot_str(obj, print_network = FALSE)
  expect_true(validate(toJSON(obj_output)))
})

test_that("test S4 objects", {
  setClass("DataExplorerPlotStrTest", representation("a" = "character", "b" = "numeric", "c" = "logical"))
  test1 <- new("DataExplorerPlotStrTest", "a" = "test", "b" = 123, "c" = TRUE)
  test2 <- new("DataExplorerPlotStrTest", "b" = 456, "c" = FALSE)
  str_output <- plot_str(list(test1, test2), print_network = FALSE)
  expect_equal(str_output$children[[1]]$children[[1]]$name, "@a (chr)")
  expect_equal(str_output$children[[2]]$children[[3]]$name, "X.c (logi)")
})

test_that("test object with 1000 columns", {
	df1 <- data.frame(replicate(1000L, sample.int(10)))
	str_df1 <- plot_str(df1, print_network = FALSE)
	expect_equal(length(str_df1), 2L)
	expect_equal(length(str_df1[[2]]), 1000L)
})
