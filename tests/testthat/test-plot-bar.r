context("plot bar charts for discrete features")

test_that("test maximum categories", {
  data(diamonds, package = "ggplot2")
  expect_error(plot_bar(iris[, 1:4]))
  expect_message(plot_bar(diamonds, maxcat = 5))
  expect_error(plot_bar(diamonds, with = "color"))
  expect_silent(plot_bar(diamonds))
  expect_silent(plot_bar(iris, with = "Sepal.Length"))
})
