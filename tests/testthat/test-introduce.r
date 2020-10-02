context("introduce")

test_that("test introduce output", {
  df <- data.frame(
    "A" = letters,
    "B" = rep(NA_character_, 26L),
    "C" = rnorm(26L),
    "D" = rep(NA_integer_, 26L),
    "E" = c(NA, letters[1L:22L], Inf, -Inf, 0/0),
    "F" = c(rpois(25L, 1L), NA)
  )
  output <- introduce(df)
  expect_equal(output[["rows"]], 26L)
  expect_equal(output[["columns"]], 6L)
  expect_equal(output[["discrete_columns"]], 2L)
  expect_equal(output[["continuous_columns"]], 2L)
  expect_equal(output[["all_missing_columns"]], 2L)
  expect_equal(output[["total_missing_values"]], 54L)
  expect_equal(output[["infinite_values"]], 2L)
  expect_equal(output[["nan_values"]], 1L)
  expect_equal(output[["total_observations"]], 156L)
  expect_is(output[["memory_usage"]], "numeric")
})


test_that("test introduce output with add_percent=T", {
  df <- data.frame(
    "A" = letters,
    "B" = rep(NA_character_, 26L),
    "C" = rnorm(26L),
    "D" = rep(NA_integer_, 26L),
    "E" = c(NA, letters[1L:22L], Inf, -Inf, 0/0),
    "F" = c(rpois(25L, 1L), NA)
  )
  output <- introduce(df, add_percent = T)
  expect_equal(output["rows", 'Count'], 26L)
  expect_equal(output["columns", 'Count'], 6L)
  expect_equal(output["discrete_columns", 'Count'], 2L)
  expect_lt(output["discrete_columns", '% of total']-2/6*100, 0.01)
  expect_equal(output["continuous_columns", 'Count'], 2L)
  expect_lt(output["continuous_columns", '% of total']-2/6*100, 0.01)
  expect_equal(output["all_missing_columns", 'Count'], 2L)
  expect_lt(output["all_missing_columns", '% of total']-2/6*100, 0.01)
  expect_equal(output["total_missing_values", 'Count'], 54L)
  expect_lt(output["total_missing_values", '% of total']-54/156*100, 0.01)
  expect_equal(output["infinite_values", 'Count'], 2L)
  expect_lt(output["infinite_values", '% of total']-2/156*100, 0.01)
  expect_equal(output["nan_values", 'Count'], 1L)
  expect_lt(output["nan_values", '% of total']-1/156*100, 0.01)
  expect_equal(output["total_observations", 'Count'], 156L)
  expect_is(output["memory_usage", 'Count'], "numeric")
})
