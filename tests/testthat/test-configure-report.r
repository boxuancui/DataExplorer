context("create report")
library(ggplot2)

test_that("test switches", {
  config <- configure_report(
    add_introduce = TRUE,
    add_plot_intro = FALSE,
    add_plot_str = TRUE,
    add_plot_missing = FALSE,
    add_plot_histogram = TRUE,
    add_plot_density = FALSE,
    add_plot_qq = TRUE, 
    add_plot_bar = FALSE,
    add_plot_correlation = TRUE,
    add_plot_prcomp = FALSE,
    add_plot_boxplot = TRUE,
    add_plot_scatterplot = FALSE
  )
  expect_setequal(names(config), c("introduce", "plot_str", "plot_histogram", "plot_qq", "plot_correlation", "plot_boxplot"))
})

test_that("test args", {
  config <- configure_report(
    plot_str_args = list(),
    plot_bar_args = list(with = "y"),
    plot_correlation_args = list("a" = list("b" = "c"))
  )
  expect_identical(config$plot_str, list())
  expect_true("with" %in% names(config$plot_bar))
  expect_identical(config$plot_bar$with, "y")
  expect_true("a" %in% names(config$plot_correlation))
  expect_true("b" %in% names(config$plot_correlation$a))
  expect_identical(config$plot_correlation$a$b, "c")
})

test_that("test global settings", {
  config <- configure_report(
    add_plot_density = TRUE,
    plot_str_args = list(),
    global_ggtheme = quote(theme_light(base_size = 10)),
    global_theme_config = list("legend.position" = "bottom", "axis.text.x" = element_text(angle = 90))
  )
  for (x in c("plot_intro", "plot_missing", "plot_histogram", "plot_density", "plot_qq", "plot_bar", "plot_correlation", "plot_prcomp", "plot_boxplot", "plot_scatterplot")) {
    expect_identical(config[[x]]$ggtheme, quote(theme_light(base_size = 10)))
    expect_identical(config[[x]]$theme_config, list(legend.position = "bottom", axis.text.x = element_text(angle = 90)))
  }
  for (x in c("introduce", "plot_str")) {
    expect_identical(config[[x]], list())
  }
})

test_that("test local theme overwrite", {
  config <- configure_report(
    plot_intro_args = list(ggtheme = quote(theme_minimal())),
    plot_missing_args = list(ggtheme = quote(theme_minimal())),
    global_ggtheme = quote(theme_light())
  )
  expect_identical(config$plot_intro$ggtheme, quote(theme_minimal()))
  expect_identical(config$plot_missing$ggtheme, quote(theme_minimal()))
  for (x in c("plot_histogram", "plot_qq", "plot_bar", "plot_correlation", "plot_prcomp", "plot_boxplot", "plot_scatterplot")) {
    expect_identical(config[[x]]$ggtheme, quote(theme_light()))
  }
})
