context("plot histogram/density")

test_that("test column names containing spaces", {
  df <- data.frame("a b" = rnorm(10), " b" = rnorm(10), "c " = rnorm(10), "d" = rnorm(10))
  expect_silent(plot_histogram(df))
  expect_silent(plot_density(df))
})

test_that("test return object", {
	histogram_list <- plot_histogram(iris)
	expect_is(histogram_list, "list")
	expect_equal(names(histogram_list), c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))
	expect_true(all(vapply(histogram_list, is.ggplot, TRUE)))

	density_list <- plot_density(iris)
	expect_is(density_list, "list")
	expect_equal(names(density_list), c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))
	expect_true(all(vapply(density_list, is.ggplot, TRUE)))
})
