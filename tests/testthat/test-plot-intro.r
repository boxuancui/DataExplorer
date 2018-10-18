context("plot intro")

test_that("test return object", {
	plot_obj <- plot_intro(iris)
	expect_true(is.ggplot(plot_obj))
})
