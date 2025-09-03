test_template <- function(template, cohort_name = "test-cohort") {
  temp_file <- tempfile()

  kyber::create_readme(
    temp_file,
    template,
    cohort_name = cohort_name,
    edit = FALSE
  )
}

test_that("Templates can be created and cohort name populated", {
  test_readme <- test_template("openscapes-cohort-readme")
  expect_true(file.exists(test_readme))

  expect_snapshot(readLines(test_readme, n = 3))
})
