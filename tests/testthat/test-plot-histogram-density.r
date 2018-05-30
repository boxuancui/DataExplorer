context("plot histogram/density")

test_that("test column names containing spaces", {
  dt <- data.table("a b" = rnorm(10), " b" = rnorm(10), "c " = rnorm(10), "d" = rnorm(10))
  expect_silent(plot_histogram(dt))
  expect_silent(plot_density(dt))
})
