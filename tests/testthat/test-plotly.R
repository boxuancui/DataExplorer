context("plotly option")

test_that("plotly = TRUE runs when plotly package is installed", {
  skip_if_not_installed("plotly")

  # Multiple-panel plots return list of ggplots (unchanged structure when plotly = TRUE)
  expect_silent(plot_bar(iris, plotly = TRUE))
  out_bar <- plot_bar(iris, plotly = TRUE)
  expect_is(out_bar, "list")
  expect_true(length(out_bar) >= 1L)

  expect_silent(plot_histogram(iris, ncol = 2L, plotly = TRUE))
  out_hist <- plot_histogram(iris, ncol = 2L, plotly = TRUE)
  expect_is(out_hist, "list")
  expect_true(all(vapply(out_hist, is.ggplot, TRUE)))

  expect_silent(plot_density(iris, ncol = 2L, plotly = TRUE))
  out_dens <- plot_density(iris, ncol = 2L, plotly = TRUE)
  expect_is(out_dens, "list")
  expect_true(all(vapply(out_dens, is.ggplot, TRUE)))

  # Single-panel plots
  expect_silent(plot_missing(airquality, plotly = TRUE))
  out_miss <- plot_missing(airquality, plotly = TRUE)
  expect_true(is.ggplot(out_miss))

  expect_silent(plot_intro(iris, plotly = TRUE))
  out_intro <- plot_intro(iris, plotly = TRUE)
  expect_true(is.ggplot(out_intro))

  expect_silent(plot_correlation(iris, plotly = TRUE))
  out_cor <- plot_correlation(iris, plotly = TRUE)
  expect_true(is.ggplot(out_cor))
})

test_that("plotly = TRUE with plot_boxplot and plot_qq when plotly is installed", {
  skip_if_not_installed("plotly")

  expect_silent(plot_boxplot(iris, by = "Species", ncol = 2L, plotly = TRUE))
  out_box <- plot_boxplot(iris, by = "Species", ncol = 2L, plotly = TRUE)
  expect_is(out_box, "list")
  expect_true(all(vapply(out_box, is.ggplot, TRUE)))

  expect_silent(plot_qq(iris, ncol = 2L, plotly = TRUE))
  out_qq <- plot_qq(iris, ncol = 2L, plotly = TRUE)
  expect_is(out_qq, "list")
  expect_true(all(vapply(out_qq, is.ggplot, TRUE)))
})

test_that("plotly = TRUE throws informative error when plotly is not installed", {
  skip_if(
    requireNamespace("plotly", quietly = TRUE),
    "plotly package is installed"
  )

  expect_error(
    plot_bar(iris, plotly = TRUE),
    "plotly",
    fixed = TRUE
  )
  expect_error(
    plot_missing(airquality, plotly = TRUE),
    "plotly",
    fixed = TRUE
  )
})

test_that("plotly = FALSE is default and unchanged behavior", {
  # Regression: default remains static ggplot
  out_bar <- plot_bar(iris)
  expect_is(out_bar, "list")
  expect_true(is.ggplot(out_bar[[1]]))

  out_miss <- plot_missing(airquality)
  expect_true(is.ggplot(out_miss))

  out_intro <- plot_intro(iris)
  expect_true(is.ggplot(out_intro))
})
