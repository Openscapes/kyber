test_that("The GitHub Clinic Folder can be created.", {
  temp_dir <- tempdir()
  clinic_path <- create_github_clinic(path = temp_dir, names = c("julia", "erin"))
  result <- all(c("erin.md", "julia.md") %in% list.files(clinic_path))
  
  # clean up
  unlink(clinic_path, recursive = TRUE, force = TRUE)
  
  expect_true(result)
})
