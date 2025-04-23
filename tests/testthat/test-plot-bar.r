context("plot bar charts for discrete features")
data(diamonds, package = "ggplot2")

test_that("test maximum categories", {
  expect_error(plot_bar(iris[, 1:4]))
  expect_message(plot_bar(diamonds, maxcat = 5L))
  expect_silent(plot_bar(diamonds))
  expect_silent(plot_bar(iris, with = "Sepal.Length"))
  expect_silent(plot_bar(diamonds, by = "cut"))
  expect_error(plot_bar(iris, maxcat = 1L))
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

test_that("test binary categories", {
  df <- data.frame(
    "a" = sample.int(n = 2L, size = 26L, replace = TRUE),
    "b" = letters,
    "c" = rnorm(26L)
  )
  expect_silent(plot_bar(df, with = "a"))
  expect_error(suppressWarnings(plot_bar(df, with = "b")))
  expect_warning(plot_bar(df, with = "c"))
  expect_silent(plot_bar(df, with = "a", binary_as_factor = FALSE))
  expect_error(plot_bar(df, by = "c"))
})
