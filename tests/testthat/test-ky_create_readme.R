test_template <- function(template){
  temp_file <- tempfile()
  
  test_file_path <- kyber::ky_create_readme(temp_file, template, edit = FALSE)
  file.exists(test_file_path)
}

test_that("Templates can be created.", {
  expect_true(test_template("openscapes-cohort-readme"))
})