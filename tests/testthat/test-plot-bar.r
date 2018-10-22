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
	expect_equal(names(plot_list), "page_1")
	expect_true(is.ggplot(plot_list[[1]]))

	plot_list2 <- plot_bar(diamonds, nrow = 1L, ncol = 1L)
	expect_is(plot_list2, "list")
	expect_equal(names(plot_list2), c("page_1", "page_2", "page_3"))
	expect_true(all(vapply(plot_list2, is.ggplot, TRUE)))
})
