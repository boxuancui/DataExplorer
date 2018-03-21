context("plot correlation heatmap")
data(diamonds, package = "ggplot2")

test_that("test maximum categories for discrete features", {
  expect_message(plot_correlation(diamonds, type = "d", maxcat = 5))
  expect_silent(plot_correlation(diamonds, type = "d"))
})

test_that("test error messages", {
  expect_error(plot_correlation(split_columns(diamonds)$continuous, type = "d"))
  expect_error(plot_correlation(split_columns(diamonds)$discrete, type = "c"))
  expect_error(suppressWarnings(plot_correlation(split_columns(diamonds)$discrete, maxcat = 2)))
})
