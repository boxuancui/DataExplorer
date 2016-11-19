context("collapse category")
data("diamonds", package = "ggplot2")

test_that("test non-data.table objects", {
  expect_error(CollapseCategory(iris, "Species", 0.2, update = TRUE))
  expect_is(CollapseCategory(iris, "Species", 0.2), "data.frame")
  expect_lt(sum(CollapseCategory(iris, "Species", 0.2)[["cnt"]]), nrow(iris))
  expect_lt(sum(CollapseCategory(iris, "Species", 0.2, "Sepal.Length")[["cnt"]]), sum(iris$Sepal.Length))
})

test_that("test data.table objects without update", {
  dt <- data.table(iris)
  expect_is(CollapseCategory(dt, "Species", 0.2), "data.table")
  expect_lt(sum(CollapseCategory(dt, "Species", 0.2)[["cnt"]]), nrow(dt))
  expect_lt(sum(CollapseCategory(dt, "Species", 0.2, "Sepal.Length")[["cnt"]]), sum(dt$Sepal.Length))
})

test_that("test update without measure", {
  dt <- data.table(diamonds)
  unique_cut_old <- levels(dt$cut)
  CollapseCategory(dt, "cut", 0.2, update = TRUE)
  unique_cut_new <- unique(dt$cut)
  expect_gte(length(unique_cut_old), length(unique_cut_new))
  expect_true("OTHER" %in% unique_cut_new)
})

test_that("test update with measure", {
  dt <- data.table(diamonds)
  unique_cut_old <- levels(dt$cut)
  CollapseCategory(dt, "cut", 0.2, measure = "price", update = TRUE)
  unique_cut_new <- unique(dt$cut)
  expect_gte(length(unique_cut_old), length(unique_cut_new))
  expect_true("OTHER" %in% unique_cut_new)
  expect_true("Ideal" %in% unique_cut_new)
  expect_true("Premium" %in% unique_cut_new)
})

test_that("test update with different name", {
  dt <- data.table(diamonds)
  CollapseCategory(dt, "cut", 0.2, update = TRUE, category_name = "New Name")
  expect_true("New Name" %in% unique(dt$cut))
})
