context("reset missing values")

test_that("test basic functionality", {
  dt <- data.table(iris)
  for (j in 1:4) set(dt, i = sample.int(150, j * 30), j, value = NA_integer_)
  num_missing <- sum(is.na(dt))
  SetNaTo(dt, 10000000)
  expect_equal(sum(is.na(dt)), 0)
  expect_equal(sum(dt == 10000000), num_missing)
})
