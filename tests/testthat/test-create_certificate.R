test_that("render_certificate works", {
  tdir <- withr::local_tempdir()
  
  cert_path <- render_certificate(
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
