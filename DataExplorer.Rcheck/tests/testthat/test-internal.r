context("internal")

test_that(".ignoreCat", {
  set.seed(1)
  dt <- data.table(
    "a" = as.factor(rep(1, 10)),
    "b" = as.factor(sample.int(2, 10, replace = TRUE)),
    "c" = as.factor(sample.int(5, 10, replace = TRUE)),
    "d" = as.factor(sample.int(10))
  )
  expect_equal(as.numeric(.ignoreCat(dt, 0)), c(1L, 2L, 5L, 10L))
  expect_equal(as.numeric(.ignoreCat(dt, 1)), c(2L, 5L, 10L))
  expect_equal(as.numeric(.ignoreCat(dt, 2)), c(5L, 10L))
  expect_equal(as.numeric(.ignoreCat(dt, 5)), 10L)
  expect_equal(names(.ignoreCat(dt, 0)), letters[1L:4L])
  expect_equal(names(.ignoreCat(dt, 1)), letters[2L:4L])
  expect_equal(names(.ignoreCat(dt, 2)), letters[3L:4L])
  expect_equal(names(.ignoreCat(dt, 5)), letters[4L])
})

test_that(".getAllMissing", {
  dt <- data.table(
    "a" = seq.int(10L),
    "b" = rep(NA_character_, 10L),
    "c" = rep(NA_integer_, 10L),
    "d" = rnorm(10L)
  )
  expect_equal(
    .getAllMissing(dt),
    c("a" = FALSE, "b" = TRUE, "c" = TRUE, "d" = FALSE))
})

test_that(".getPageLayout", {
	expect_equal(.getPageLayout(2, 2, 6), list("Page 1" = seq.int(4L), "Page 2" = c(5L, 6L)))
	expect_equal(.getPageLayout(3, 3, 6), list("Page 1" = seq.int(6L)))
})
