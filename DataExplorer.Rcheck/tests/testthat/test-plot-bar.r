context("plot bar charts for discrete features")
data(diamonds, package = "ggplot2")

test_that("test maximum categories", {
  expect_error(plot_bar(iris[, 1:4]))
  expect_message(plot_bar(diamonds, maxcat = 5))
  expect_silent(plot_bar(diamonds))
  expect_silent(plot_bar(iris, with = "Sepal.Length"))
})

test_that("test return object", {
	plot_list <- plot_bar(diamonds)
	expect_is(plot_list, "list")
	expect_equal(names(plot_list), c("cut", "color", "clarity"))
	expect_true(all(vapply(plot_list, is.ggplot, TRUE)))
})
