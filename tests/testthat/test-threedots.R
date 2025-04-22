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

test_that("plot_boxplot works with no aesthetics", {
  expect_invisible(plot_boxplot(iris, by = "Species"))
})

test_that("plot_boxplot works with mapped aesthetic (fill)", {
  expect_invisible(plot_boxplot(iris, by = "Species", fill = Species))
})

test_that("plot_boxplot works with constant aesthetic (alpha)", {
  expect_invisible(plot_boxplot(iris, by = "Species", alpha = 0.5))
})

test_that("plot_boxplot works with both mapped and constant aesthetics", {
  expect_invisible(plot_boxplot(iris, by = "Species", fill = Species, alpha = 0.3))
})

test_that("plot_scatterplot works with no aesthetics", {
  expect_invisible(plot_scatterplot(iris, by = "Species"))
})

test_that("plot_scatterplot works with mapped aesthetic (fill)", {
  expect_invisible(plot_scatterplot(iris, by = "Species", fill = Species))
})

test_that("plot_scatterplot works with constant aesthetic (alpha)", {
  expect_invisible(plot_scatterplot(iris, by = "Species", alpha = 0.5))
})

test_that("plot_scatterplot works with both mapped and constant aesthetics", {
  expect_invisible(plot_scatterplot(iris, by = "Species", fill = Species, alpha = 0.3))
})

test_that("plot_density works with no aesthetics", {
  expect_invisible(plot_density(iris))
})

test_that("plot_density works with mapped aesthetic (fill)", {
  expect_invisible(plot_density(iris, fill = Species))
})

test_that("plot_density works with constant aesthetic (alpha)", {
  expect_invisible(plot_density(iris, alpha = 0.4))
})

test_that("plot_density works with both mapped and constant aesthetics", {
  expect_invisible(plot_density(iris, fill = Species, alpha = 0.3))
})
