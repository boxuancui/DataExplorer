context("scatterplot")

test_that("test scales", {
  expect_silent(plot_scatterplot(na.omit(airquality), by = "Ozone", scale_x = "reverse", scale_y = "sqrt"))
  expect_silent(plot_scatterplot(iris, by = "Species", scale_y = "log10"))
  expect_error(plot_scatterplot(iris, by = "Species", scale_x = "log10"))
  expect_error(plot_scatterplot(iris, by = "Species", scale_x = "log"))
})

test_that("test return object", {
  scatterplot_list <- plot_scatterplot(iris, by = "Species")
  expect_is(scatterplot_list, "list")
  expect_equal(names(scatterplot_list), "page_1")
  expect_true(is.ggplot(scatterplot_list[[1]]))
  
  scatterplot_list2 <- plot_scatterplot(iris, by = "Species", nrow = 1L, ncol = 1L)
  expect_is(scatterplot_list2, "list")
  expect_equal(names(scatterplot_list2), c("page_1", "page_2", "page_3", "page_4"))
  expect_true(all(vapply(scatterplot_list2, is.ggplot, TRUE)))
})
