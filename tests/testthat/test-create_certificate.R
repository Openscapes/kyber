test_that("create_certificate works", {
  tdir <- withr::local_tempdir()

  cert_path <- create_certificate(
    "Test cohort",
    first_name = "Jane",
    last_name = "Doe",
    start_date = "2024-10-19",
    end_date = "2024-12-19",
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
    start_date = "2024-10-19",
    end_date = "2024-12-19",
    cohort_website = "https://google.com",
    cohort_type = "nmfs",
    output_dir = tdir
  )

  expect_true(file.exists(
    file.path(tdir, "OpenscapesCertificate_NMFS-Openscapes-2024_Jane-Doe.pdf")
  ))
})

test_that("create_certificate works with pathways", {
  tdir <- withr::local_tempdir()

  cert_path <- create_certificate(
    first_name = "Jane",
    last_name = "Doe",
    start_date = "2024-10-19",
    end_date = "2024-12-19",
    cohort_type = "pathways",
    output_dir = tdir
  )

  expect_true(file.exists(
    file.path(tdir, "Certificate_Pathways-to-Open-Science-2024_Jane-Doe.pdf")
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

test_that("create_batch_certificates gives message when it fails but still proceeds", {
  tdir <- withr::local_tempdir()

  participants <- dplyr::tibble(
    cohort = "2024-nmfs-champions-a",
    first = "Sally",
    last = "Green"
  )

  registry <- dplyr::tibble(
    cohort_name = "2024-nmfs-champions-a",
    date_start = "yesterday", # will cause certificate create to fail
    date_end = "2024-02-02",
    cohort_website = "https://nmfs-openscapes.github.io/2024-nmfs-champions"
  )

  expect_snapshot(
    create_batch_certificates(
      registry = registry,
      participants = participants,
      cohort_name = "2024-nmfs-champions-a",
      cohort_type = "nmfs",
      output_dir = file.path(tdir, "nmfs-a")
    ),
    transform = \(x) gsub("\\[1\\] .+(/nmfs-a)", "[1] \"output_dirname\\1", x)
  )
})

test_that("create_batch_pathways_certificates works with defaults", {
  tdir <- withr::local_tempdir()

  participants <- dplyr::tibble(
    participant_name = c(
      "Firstname Lastname",
      "Firstname MiddleName Lastname"
    )
  )

  create_batch_pathways_certificates(
    participants = participants,
    start_date = "2024-01-01",
    end_date = "2024-02-01",
    output_dir = file.path(tdir, "pathways")
  )

  expect_snapshot(
    list.files(tdir, recursive = TRUE)
  )
})

test_that("create_batch_pathways_certificates proceeds with warning when one column with unexpected name", {
  tdir <- withr::local_tempdir()

  participants <- dplyr::tibble(
    other_name = c(
      "Firstname Lastname",
      "Firstname MiddleName Lastname"
    )
  )

  expect_snapshot(
    suppressMessages(
      create_batch_pathways_certificates(
        participants = participants,
        start_date = "2024-01-01",
        end_date = "2024-02-01",
        output_dir = file.path(tdir, "pathways")
      )
    ),
    transform = function(x) gsub("\\[1].+", "", x)
  )

  expect_snapshot(
    list.files(tdir, recursive = TRUE)
  )
})

test_that("create_batch_pathways_certificates errors when > 1 unexpected column", {
  tdir <- withr::local_tempdir()

  participants <- dplyr::tibble(
    first_col = c(
      "Firstname Lastname",
      "Firstname MiddleName Lastname"
    ),
    second_col = 1:2
  )

  expect_snapshot(
    suppressMessages(
      create_batch_pathways_certificates(
        participants = participants,
        start_date = "2024-01-01",
        end_date = "2024-02-01",
        output_dir = file.path(tdir, "pathways")
      )
    ),
    error = TRUE
  )
})

test_that("create_batch_pathways_certificates works with a character vector", {
  tdir <- withr::local_tempdir()

  participants <- c("Firstname Lastname", "Firstname MiddleName Lastname")

  create_batch_pathways_certificates(
    participants = participants,
    start_date = "2024-01-01",
    end_date = "2024-02-01",
    output_dir = file.path(tdir, "pathways")
  )

  expect_snapshot(
    list.files(tdir, recursive = TRUE)
  )
})

test_that("create_batch_pathways_certificates works specifying more args", {
  tdir <- withr::local_tempdir()

  participants <- dplyr::tibble(
    participant_name = c(
      "Firstname Lastname",
      "Firstname MiddleName Lastname"
    )
  )

  create_batch_pathways_certificates(
    participants = participants,
    start_date = "2024-01-01",
    end_date = "2024-02-01",
    cohort_name = "test pathways cohort",
    cohort_website = "https://test-pathways",
    output_dir = file.path(tdir, "pathways")
  )

  expect_snapshot(
    list.files(tdir, recursive = TRUE)
  )
})
