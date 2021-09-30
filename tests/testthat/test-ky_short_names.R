test_that("Short names are created correctly.", {
  first <- c("a", "b", "c")
  last <- c("x1", "y2", "z3")
  expect_equal(ky_short_names(first, last), c("a", "b", "c"))

  
  first <- c("a", "a", "c")
  last <- c("x1", "y2", "z3")
  expect_equal(ky_short_names(first, last), c("a_x", "a_y", "c"))
  
  first <- c("a", "a", "c")
  last <- c("x144", "x255", "z3")
  expect_equal(ky_short_names(first, last), c("a_x144", "a_x255", "c"))
  
  first <- c("a", "a", "c", "d", "d")
  last <- c("x144", "x255", "z3", "r4", "t5")
  expect_equal(ky_short_names(first, last), c("a_x144", "a_x255", "c", "d_r", "d_t"))
  
  first <- c("a", "a", "c")
  last <- c("x1", "x1", "z3")
  expect_warning(ky_short_names(first, last))
})
