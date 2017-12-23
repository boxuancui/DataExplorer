context("plot bar charts for discrete features")

test_that("test maximum categories", {
  data(diamonds, package = "ggplot2")
  expect_message(plot_bar(diamonds, maxcat = 5))
  expect_silent(plot_bar(diamonds))
})
