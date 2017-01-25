context("bar charts for discrete features")

test_that("test maximum categories", {
  data(diamonds, package = "ggplot2")
  expect_message(BarDiscrete(diamonds, maxcat = 5))
  expect_silent(BarDiscrete(diamonds))
})
