context("update variables")

test_that("test basic functionality", {
  iris_dt <- data.table(iris)
  update_columns(iris_dt, 1L, as.character)
  update_columns(iris_dt, c("Sepal.Width", "Petal.Length"), as.factor)
  update_columns(iris_dt, "Petal.Width", as.integer)
  expect_is(iris_dt[[1]], "character")
  expect_is(iris_dt$Sepal.Width, "factor")
  expect_is(iris_dt$Petal.Length, "factor")
  expect_is(iris_dt$Petal.Width, "integer")
  expect_is(iris_dt, "data.table")
})

test_that("test non-data.table objects", {
  expect_is(update_columns(iris, 1L, as.character), "data.frame")
})
