context("introduce")

test_that("test introduce output", {
  df <- data.frame(
    "A" = letters,
    "B" = rep(NA_character_, 26L),
    "C" = rnorm(26L),
    "D" = rep(NA_integer_, 26L),
    "E" = c(NA, letters[1L:25L]),
    "F" = c(rpois(25L, 1L), NA)
  )
  expect_identical(
    introduce(df),
    data.frame(
      "rows" = 26L,
      "columns" = 6L,
      "discrete_columns" = 2L,
      "continuous_columns" = 2L,
      "all_missing_columns" = 2L,
      "total_missing_values" = 54L,
      "total_observations" = 156L,
      "size" = as.factor("6.4 Kb")
    )
  )
})
