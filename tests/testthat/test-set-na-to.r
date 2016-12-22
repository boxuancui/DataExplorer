context("reset missing values")

test_that("test single numerical value", {
  dt <- data.table(iris)
  for (j in 1:4) set(dt, i = sample.int(150, j * 30), j, value = NA_integer_)
  num_missing <- sum(is.na(dt))
  SetNaTo(dt, 10000000)
  expect_equal(sum(is.na(dt)), 0)
  expect_equal(sum(dt == 10000000), num_missing)
})

test_that("test single string value", {
  dt <- data.table(iris)
  set(dt, i = sample.int(150, 25), 5L, value = NA_character_)
  num_missing <- sum(is.na(dt))
  SetNaTo(dt, "unknown")
  expect_equal(sum(is.na(dt)), 0)
  expect_equal(sum(dt == "unknown"), num_missing)
})

my_dt <- data.table(
  "a" = c(1, 4, NA, NA, 3, NA),
  "b" = c(1, NA, 5, 2, 3, NA),
  "c" = c(1, "abc", NA, NA, 3, NA),
  "d" = c(1, "4", NA, "def", 3, 2),
  "e" = c(1, 4, 2, 3, 3, 1)
)

test_that("test list of both value", {
  SetNaTo(my_dt, list(50, "unknown"))
  expect_equal(sum(is.na(my_dt)), 0)
  expect_equal(sum(my_dt == 50), 5)
  expect_equal(sum(my_dt == "unknown"), 4)
})

test_that("test list of numerical values", {
  expect_error(SetNaTo(my_dt, list(50, 50)))
})

test_that("test list of string values", {
  expect_error(SetNaTo(my_dt, list("qwerty", "uiop")))
})

test_that("test non-list", {
  expect_error(SetNaTo(my_dt, c(0, "qwerty")))
})

test_that("test more than two values", {
  expect_error(SetNaTo(my_dt, list(0, 3, 4)))
})
