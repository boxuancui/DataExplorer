context("plot principle component analysis")

test_that("test error", {
	expect_silent(plot_prcomp(iris))
	expect_error(plot_prcomp(airquality))
})
