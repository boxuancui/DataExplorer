context("plot histogram/density")

test_that("test column names containing spaces", {
  df <- data.frame("a b" = rnorm(10), " b" = rnorm(10), "c " = rnorm(10), "d" = rnorm(10))
  expect_silent(plot_histogram(df))
  expect_silent(plot_density(df))
})

test_that("test return object", {
	histogram_list <- plot_histogram(iris)
	expect_is(histogram_list, "list")
	expect_equal(names(histogram_list), "page_1")
	expect_true(is.ggplot(histogram_list[[1]]))

	histogram_list2 <- plot_histogram(iris, nrow = 1L, ncol = 1L)
	expect_is(histogram_list2, "list")
	expect_equal(names(histogram_list2), c("page_1", "page_2", "page_3", "page_4"))
	expect_true(all(vapply(histogram_list2, is.ggplot, TRUE)))

	density_list <- plot_density(iris)
	expect_is(density_list, "list")
	expect_equal(names(density_list), "page_1")
	expect_true(is.ggplot(density_list[[1]]))

	density_list2 <- plot_density(iris, nrow = 1L, ncol = 1L)
	expect_is(density_list2, "list")
	expect_equal(names(density_list2), c("page_1", "page_2", "page_3", "page_4"))
	expect_true(all(vapply(density_list2, is.ggplot, TRUE)))
})

test_that("test binary categories and error messages", {
  df <- sample.int(n = 2L, size = 26L, replace = TRUE)
  expect_silent(plot_histogram(sample.int(n = 2L, size = 26L, replace = TRUE), binary_as_factor = FALSE))
  expect_error(plot_histogram(sample.int(n = 2L, size = 26L, replace = TRUE)))
  expect_silent(plot_density(sample.int(n = 2L, size = 26L, replace = TRUE), binary_as_factor = FALSE))
  expect_error(plot_density(sample.int(n = 2L, size = 26L, replace = TRUE)))
})
