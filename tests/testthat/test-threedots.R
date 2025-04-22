context("three-dots")

test_that("plot_histogram works with no aesthetics", {
  expect_invisible(plot_histogram(iris))
})

test_that("plot_histogram works with mapped aesthetic (fill)", {
  expect_invisible(plot_histogram(iris, fill = Species))
})

test_that("plot_histogram works with constant aesthetic (alpha)", {
  expect_invisible(plot_histogram(iris, alpha = 0.5))
})

test_that("plot_histogram works with both mapped and constant aesthetics", {
  expect_invisible(plot_histogram(iris, fill = Species, alpha = 0.3))
})

test_that("plot_bar works with no aesthetics", {
  expect_invisible(plot_bar(iris))
})

test_that("plot_bar works with mapped aesthetic (fill)", {
  expect_invisible(plot_bar(iris, fill = Species))
})

test_that("plot_bar works with constant aesthetic (alpha)", {
  expect_invisible(plot_bar(iris, alpha = 0.5))
})

test_that("plot_bar works with both mapped and constant aesthetics", {
  expect_invisible(plot_bar(iris, fill = Species, alpha = 0.4))
})
