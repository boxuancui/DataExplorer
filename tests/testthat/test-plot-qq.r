context("plot qq")

test_that("test return object", {
	df <- data.frame(replicate(8, rnorm(10)))
	plot_list <- plot_qq(df, nrow = 2L, ncol = 2L)
	expect_is(plot_list, "list")
	expect_equal(names(plot_list), c("page_1", "page_2"))
	expect_true(all(vapply(plot_list, is.ggplot, TRUE)))
})
