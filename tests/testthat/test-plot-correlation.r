context("plot correlation heatmap")

test_that("test maximum categories for discrete features", {
  data(diamonds, package = "ggplot2")
  expect_message(plot_correlation(diamonds, type = "d", maxcat = 5))
  expect_silent(plot_correlation(diamonds, type = "d"))
})
