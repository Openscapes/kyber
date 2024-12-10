test_that("create_certificate works", {
  tdir <- withr::local_tempdir()
  
  cert_path <- create_certificate(
    "Test cohort",
    first_name = "Jane",
    last_name = "Doe",
    start_date = "Oct 19",
    end_date = "Dec 19",
    cohort_website = "https://google.com",
    output_dir = tdir
  )
  
  expect_true(file.exists(
    file.path(tdir, "OpenscapesCertificate_Test-cohort_Jane-Doe.pdf")
  ))
})

test_that("create_certificate works with nmfs", {
  tdir <- withr::local_tempdir()
  
  cert_path <- create_certificate(
    "NMFS Openscapes 2024",
    first_name = "Jane",
    last_name = "Doe",
    start_date = "Oct 19",
    end_date = "Dec 19",
    cohort_website = "https://google.com",
    cohort_type = "nmfs",
    output_dir = tdir
  )
  
  expect_true(file.exists(
    file.path(tdir, "OpenscapesCertificate_NMFS-Openscapes-2024_Jane-Doe.pdf")
  ))
})

test_that("create_batch_certificates works", {
  tdir <- withr::local_tempdir()

  participants <- dplyr::tibble(
      cohort = c(
        "2024-nmfs-champions-a",
        "2024-nmfs-champions-a",
        "2024-champions",
        "2024-champions"
      ),
      first = c("Sally", "Rupert", "Lily", "Leo"),
      last = c("Green", "White", "Brown", "Blue")
    )
  
  registry <- dplyr::tibble(
    cohort_name = c(
      "2024-nmfs-champions-a",
      "2024-nmfs-champions-b",
      "2024-champions"
    ),
    date_start = c("2024-01-01", "2024-05-05", "2024-10-10"),
    date_end = c("2024-02-02", "2024-06-06", "2024-11-11"),
    cohort_website = c(
      "https://nmfs-openscapes.github.io/2024-nmfs-champions",
      "https://nmfs-openscapes.github.io/2024-nmfs-champions",
      "https://nasa-openscapes.github.io/2024-nasa-champions"
    )
  )

  create_batch_certificates(
    registry = registry,
    participants = participants,
    cohort_name = "2024-nmfs-champions-a",
    cohort_type = "nmfs",
    output_dir = file.path(tdir, "nmfs-a")
  )

  create_batch_certificates(
    registry = registry,
    participants = participants,
    cohort_name = "2024-champions",
    cohort_type = "nmfs",
    output_dir = file.path(tdir, "nasa")
  )

  expect_snapshot(
    list.files(tdir, recursive = TRUE)
  )
})
