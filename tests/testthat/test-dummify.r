context("dummify")
data("diamonds", package = "ggplot2")

test_that("test return object class", {
  expect_equal(class(diamonds), class(dummify(diamonds, maxcat = 5)))
  expect_equal(class(iris), class(dummify(iris)))
  expect_is(dummify(data.table("D" = letters[1:5])), "data.table")
})

test_that("test messages and warnings", {
  expect_message(dummify(diamonds, maxcat = 5))
  expect_warning(dummify(iris, maxcat = 2))
  expect_warning(dummify(airquality))
})

test_that("test feature count", {
  expect_equal(ncol(dummify(diamonds)), 27L)
  expect_equal(ncol(dummify(diamonds, maxcat = 5)), 14L)
  expect_equal(ncol(dummify(data.table("A" = letters[1:5]))), 5L)
  expect_equal(ncol(dummify(data.table("A" = letters[1:5], "B" = letters[6:10]))), 10L)
})

test_that("test binary outcome", {
  expect_equal(max(dummify(data.table("A" = letters[1:5]))), 1L)
  expect_equal(min(dummify(data.table("A" = letters[1:5]))), 0L)
})

test_that("test continuous features", {
  expect_equivalent(split_columns(diamonds)$continuous, split_columns(dummify(diamonds))$continuous[, 1:7])
})
