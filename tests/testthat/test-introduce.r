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
