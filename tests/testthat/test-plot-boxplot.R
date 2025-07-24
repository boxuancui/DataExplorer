context("boxplot")

test_that("test scales", {
  expect_error(plot_scatterplot(iris, by = "Species", scale_x = "log"))
})

test_that("test return object", {
  boxplot_list <- plot_boxplot(iris, by = "Species")
  expect_is(boxplot_list, "list")
  expect_equal(names(boxplot_list), "page_1")
  expect_true(is.ggplot(boxplot_list[[1]]))
  
  boxplot_list2 <- plot_boxplot(iris, by = "Species", nrow = 1L, ncol = 1L)
  expect_is(boxplot_list2, "list")
  expect_equal(names(boxplot_list2), c("page_1", "page_2", "page_3", "page_4"))
  expect_true(all(vapply(boxplot_list2, is.ggplot, TRUE)))
})
