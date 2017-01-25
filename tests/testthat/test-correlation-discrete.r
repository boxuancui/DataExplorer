context("correlation heatmap for discrete features")

test_that("test maximum categories", {
  data(diamonds, package = "ggplot2")
  expect_message(CorrelationDiscrete(diamonds, maxcat = 5))
  expect_silent(CorrelationDiscrete(diamonds))
})
