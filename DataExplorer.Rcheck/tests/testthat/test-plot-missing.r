context("plot missing data profile")

test_that("test return object", {
	plot_obj <- plot_missing(airquality)
	expect_true(is.ggplot(plot_obj))
})
