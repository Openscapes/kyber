test_that("The GitHub Clinic Folder can be created.", {
  temp_dir <- tempdir()
  clinic_path <- create_github_clinic(
    path = temp_dir,
    names = c("julia", "erin")
  )
  result <- all(c("erin.md", "julia.md") %in% list.files(clinic_path))

  # clean up
  unlink(clinic_path, recursive = TRUE, force = TRUE)

  expect_true(result)
})

test_that("Fails with duplicate names", {
  expect_snapshot(
    create_github_clinic(names = c("julia", "erin", "julia")),
    error = TRUE
  )
})

test_that("Interaction with existing file names works (#120)", {
  cohort <- tibble::tribble(
    ~first,   ~last,
    "Erin",   "Robinson",
    "Erin",   "Lowndes",
    "Stef",   "Butland"
  )

  dir <- withr::local_tempdir()

  kyber::short_names(cohort$first, cohort$last) |>
    create_github_clinic(dir)

  list.files(file.path(dir, "github-clinic"))

  expect_snapshot(
    kyber::short_names("Stef", "Jones") |>
      create_github_clinic(dir)
  )

  expect_snapshot(
    list.files(file.path(dir, "github-clinic"))
  )
})
