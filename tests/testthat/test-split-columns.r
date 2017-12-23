context("split column type")
data("diamonds", package = "ggplot2")

test_that("test data.table return object", {
  dt <- data.table(diamonds)
  dt_output <- split_columns(dt)
  expect_equal(
    names(dt_output)[order(names(dt_output))],
    c("continuous", "discrete", "num_all_missing", "num_continuous", "num_discrete")
  )
  expect_is(dt_output$discrete, "data.table")
  expect_is(dt_output$continuous, "data.table")
  expect_equal(
    sum(dt_output$num_discrete, dt_output$num_continuous, dt_output$num_all_missing),
    ncol(dt)
  )
})

test_that("test data.frame return object", {
  df <- data.frame(diamonds)
  df_output <- split_columns(df)
  expect_equal(
    names(df_output)[order(names(df_output))],
    c("continuous", "discrete", "num_all_missing", "num_continuous", "num_discrete")
  )
  expect_is(df_output$discrete, "data.frame")
  expect_is(df_output$continuous, "data.frame")
  expect_equal(
    sum(df_output$num_discrete, df_output$num_continuous, df_output$num_all_missing),
    ncol(df)
  )
})
