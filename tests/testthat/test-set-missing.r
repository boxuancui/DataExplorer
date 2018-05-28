context("set missing values")

test_that("test single numerical value", {
  dt <- data.table(iris)
  for (j in 1:4) set(dt, i = sample.int(150, j * 30), j, value = NA_integer_)
  num_missing <- sum(is.na(dt))
  set_missing(dt, 10000000)
  expect_equal(sum(is.na(dt)), 0)
  expect_equal(sum(dt == 10000000), num_missing)
})

test_that("test single string value", {
  dt <- data.table(iris)
  set(dt, i = sample.int(150, 25), 5L, value = NA_character_)
  num_missing <- sum(is.na(dt))
  set_missing(dt, "unknown")
  expect_equal(sum(is.na(dt)), 0)
  expect_equal(sum(dt == "unknown"), num_missing)
})

test_that("test single value excluding columns", {
  dt <- data.table(iris)
  set(dt, i = sample.int(150, 25), 5L, value = NA_character_)
  num_missing <- sum(is.na(dt))
  set_missing(dt, "unknown", names(dt)[5L])
  expect_equal(sum(is.na(dt)), num_missing)
})

my_dt <- data.table(
  "a" = c(1, 4, NA, NA, 3, NA),
  "b" = c(1, NA, 5, 2, 3, NA),
  "c" = c(1, "abc", NA, NA, 3, NA),
  "d" = c(1, "4", NA, "def", 3, 2),
  "e" = c(1, 4, 2, 3, 3, 1)
)
my_dt2 <- copy(my_dt)

test_that("test list of both value", {
  set_missing(my_dt, list(50L, "unknown"))
  expect_equal(sum(is.na(my_dt)), 0L)
  expect_equal(sum(my_dt == 50L), 5L)
  expect_equal(sum(my_dt == "unknown"), 4L)
})

test_that("test multiple values excluding columns", {
  set_missing(my_dt2, list(50L, "unknown"), c("a", "e"))
  expect_equal(sum(is.na(my_dt2$a)), 3L)
  expect_equal(sum(my_dt2$b == 50L), 2L)
  expect_equal(sum(is.na(my_dt2$e)), 0L)
})

test_that("test list of numerical values", {
  expect_error(set_missing(my_dt, list(50, 50)))
})

test_that("test list of string values", {
  expect_error(set_missing(my_dt, list("qwerty", "uiop")))
})

test_that("test non-list", {
  expect_error(set_missing(my_dt, c(0, "qwerty")))
})

test_that("test more than two values", {
  expect_error(set_missing(my_dt, list(0, 3, 4)))
})

test_that("test non-data.table objects", {
  expect_equal(class(set_missing(airquality, 0L)), class(airquality))
  expect_equal(dim(set_missing(airquality, 0L)), dim(airquality))
  expect_equal(introduce((set_missing(airquality, 0L)))[["total_missing_values"]], 0L)
})
