context("drop variables")

test_that("test basic functionality", {
  dt <- data.table(sapply(setNames(letters, letters), function(x) {assign(x, rnorm(100))}))
  dt2 <- copy(dt)
  n <- nrow(dt)
  DropVar(dt, letters[2:25])
  DropVar(dt2, seq(2, 25))
  expect_equal(dim(dt), c(n, 2))
  expect_equal(names(dt), c("a", "z"))
  expect_equal(dim(dt2), c(n, 2))
  expect_equal(names(dt2), c("a", "z"))
})
