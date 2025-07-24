context("group category")
data("diamonds", package = "ggplot2")

test_that("test non-data.table objects without update", {
  expect_is(group_category(iris, "Species", 0.2), "data.frame")
  expect_lt(sum(group_category(iris, "Species", 0.2)[["cnt"]]), nrow(iris))
  expect_lt(sum(group_category(iris, "Species", 0.2, "Sepal.Length")[["cnt"]]), sum(iris$Sepal.Length))
})

test_that("test data.table objects without update", {
  dt <- data.table(iris)
  expect_is(group_category(dt, "Species", 0.2), "data.table")
  expect_lt(sum(group_category(dt, "Species", 0.2)[["cnt"]]), nrow(dt))
  expect_lt(sum(group_category(dt, "Species", 0.2, "Sepal.Length")[["cnt"]]), sum(dt$Sepal.Length))
})

test_that("test update without measure", {
  dt <- data.table(diamonds)
  unique_cut_old <- levels(dt$cut)
  group_category(dt, "cut", 0.2, update = TRUE)
  unique_cut_new <- unique(dt$cut)
  expect_gte(length(unique_cut_old), length(unique_cut_new))
  expect_true("OTHER" %in% unique_cut_new)
})

test_that("test update with measure", {
  dt <- data.table(diamonds)
  unique_cut_old <- levels(dt$cut)
  group_category(dt, "cut", 0.2, measure = "price", update = TRUE)
  unique_cut_new <- unique(dt$cut)
  expect_gte(length(unique_cut_old), length(unique_cut_new))
  expect_true("OTHER" %in% unique_cut_new)
  expect_true("Ideal" %in% unique_cut_new)
  expect_true("Premium" %in% unique_cut_new)
})

test_that("test update with different name", {
  dt <- data.table(diamonds)
  group_category(dt, "cut", 0.2, update = TRUE, category_name = "New Name")
  expect_true("New Name" %in% unique(dt$cut))
})

test_that("test excluding columns", {
  dt <- data.table("a" = c(rep("c1", 25), rep("c2", 10), "c3", "c4"))
  group_category(dt, "a", 0.8, update = TRUE, exclude = c("c3", "c4"))
  expect_identical(unique(dt$a), c("OTHER", "c3", "c4"))
})

test_that("test non-data.table objects with update", {
  expect_is(group_category(iris, "Species", 0.2, update = TRUE), "data.frame")
  expect_equal(class(group_category(diamonds, "cut", 0.2, update = TRUE)), class(diamonds))
  expect_equal(dim(group_category(iris, "Species", 0.2, update = TRUE)), dim(iris))
})
