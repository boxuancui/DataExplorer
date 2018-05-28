context("plot correlation heatmap")
data(diamonds, package = "ggplot2")

test_that("test normal functions", {
  expect_silent(plot_correlation(data.frame("a" = rnorm(10))))
  expect_silent(plot_correlation(data.frame("a" = rnorm(10), "b" = rnorm(10))))
  expect_silent(plot_correlation(data.frame("a" = rnorm(10), "b" = rnorm(10)), type = "c"))
})

test_that("test maximum categories for discrete features", {
  expect_message(plot_correlation(diamonds, type = "d", maxcat = 5))
  expect_silent(plot_correlation(iris, type = "d"))
})

test_that("test error messages", {
  expect_error(plot_correlation(split_columns(iris)$continuous, type = "d"))
  expect_error(plot_correlation(split_columns(iris)$discrete, type = "c"))
})
