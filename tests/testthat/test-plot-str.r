context("plot data structure")
library(jsonlite)

test_that("test nested levels", {
  iris_output <- plot_str(iris, print_network = FALSE)
  expect_equal(length(iris_output), 2)
  obj <- list(list(list(list("a" = 1L))))
  obj_output <- plot_str(obj, print_network = FALSE)
  expect_equal(obj_output$children[[1]]$children[[1]]$children[[1]]$children[[1]]$name, "a (int)")
})

test_that("test returned object is valid json", {
  obj <- list(lm(rnorm(5) ~ letters[1:5]), list(iris), list(list(list("a" = 1L))))
  obj_output <- plot_str(obj, print_network = FALSE)
  expect_true(validate(toJSON(obj_output)))
})
