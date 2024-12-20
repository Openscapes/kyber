#' Render certificates of completion for a participant in a cohort
#'
#' @param cohort_name The name of the cohort
#' @param first_name First name of participant
#' @param last_name Last name of participant
#' @param start_date cohort start date. `Date` or character in a standard format
#'     (eg., YYYY-MM-DD)
#' @param end_date cohort end date. `Date` or character in a standard format
#'     (eg., YYYY-MM-DD)
#' @param cohort_website cohort website
#' @param cohort_type What kind of cohort are the certificates for? This will
#'     choose the appropriate certificate template: `"standard"` (default) or
#'     `"nmfs"`.
#' @param output_dir output directory for certificates. Default `"."`
#' @param quiet Suppress quarto warnings and other messages. Default `TRUE`.
#'     Set to `FALSE` to help debug if any errors occur.
#' @param ... Other parameters passed on to [quarto::quarto_render()]
#'
#' @return Saves the file to the specified directory, and returns the path to
#'     the file
#' @export
#'
#' @examples
#' \dontrun{
#' create_certificate(
#'   cohort_name = "2023-fred-hutch",
#'   first_name = "FirstName",
#'   last_name = "LastName",
#'   start_date = "2023-09-19",
#'   end_date = "2023-10-19",
#'   cohort_website = "https://openscapes.github.io/2023-fred-hutch/",
#'   cohort_type = "standard"
#' )
#' }
create_certificate <- function(
    cohort_name,
    first_name,
    last_name,
    start_date,
    end_date,
    cohort_website,
    cohort_type = c("standard", "nmfs"),
    output_dir = ".",
    quiet = TRUE,
    ...) {
  # adapted from https://bookdown.org/yihui/rmarkdown/params-knit.html

  cohort_type <- match.arg(cohort_type)

  start_date <- as.Date(start_date)
  end_date <- as.Date(end_date)

  template <- switch(cohort_type,
    standard = system.file("certificate/certificate.qmd", package = "kyber"),
    nmfs = system.file("certificate/certificate-nmfs.qmd", package = "kyber")
  )

  participant_name <- paste(first_name, last_name)

  outfile <- paste0(
    "OpenscapesCertificate",
    "_",
    gsub("\\s+", "-", cohort_name),
    "_",
    gsub("\\s+", "-", participant_name),
    ".pdf"
  )

  cohort_name_formatted <- cohort_name |>
    stringr::str_replace_all("[-_]+", " ") |>
    stringr::str_to_title() |>
    stringr::str_replace("[Nn][mM][fF][sS]", "NMFS")

  quarto::quarto_render(
    template,
    output_format = "typst",
    execute_params = list(
      cohort_name = cohort_name_formatted,
      participant_name = participant_name,
      start_date = format(start_date, "%B %d, %Y"),
      end_date = format(end_date, "%B %d, %Y"),
      cohort_website = cohort_website
    ),
    output_file = outfile,
    quiet = quiet,
    ...
  )

  if (output_dir != ".") {
    fs::dir_create(output_dir)
    fs::file_move(outfile, output_dir)
  }

  cli::cli_inform(
    c("v" = "File written to {.path {fs::path(output_dir, outfile)}}")
  )
}

#' Render a batch of certificates for a Champions Cohort
#'
#' Given a data.frame of Champions participants and a Cohort registry,
#' create a certificate for each participant
#'
#' @param registry `data.frame` from Google Sheet of Champions registry
#'        (`"OpenscapesChampionsCohortRegistry"`)
#' @param participants `data.frame` from Google Sheet of Champions participants
#'        (`"OpenscapesParticipantsMainList"`)
#' @param cohort_name Name of the cohort as it appears in `registry` and
#'        `participants`
#' @inheritParams create_certificate
#'
#' @return path to the directory containing the certificates
#' @export
#'
#' @examples
#' \dontrun{
#' registry <- read_sheet("path-to-registry")
#' participants <- read_sheet("path-to-participants")
#'
#' create_batch_certificates(
#'   registry,
#'   particpants,
#'   "2023-fred-hutch",
#'   "~/Desktop/fred-hutch-certificates"
#' )
#' }
create_batch_certificates <- function(
    registry,
    participants,
    cohort_name,
    cohort_type = c("standard", "nmfs", "pathways"),
    output_dir = ".") {
  if (!cohort_name %in% registry$cohort_name) {
    stop("'cohort_name' is not a cohort in 'registry_sheet'", call. = FALSE)
  }

  if (!cohort_name %in% participants$cohort) {
    stop("'cohort_name' is not a cohort in 'participant_sheet'", call. = FALSE)
  }

  cohort_type <- match.arg(cohort_type)

  registry_cohort <- dplyr::filter(
    registry,
    .data$cohort_name == !!cohort_name
  )

  participants_cohort <- dplyr::filter(
    participants,
    .data$cohort == !!cohort_name
  )

  ## Loop through each participant in list and create certificate for each

  dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

  for (row in seq_len(nrow(participants_cohort))) {
    tryCatch(
      {
        first_name <- participants_cohort$first[row]
        last_name <- participants_cohort$last[row]

        create_certificate(
          cohort_name = cohort_name,
          first_name = first_name,
          last_name = last_name,
          start_date = registry_cohort$date_start,
          end_date = registry_cohort$date_end,
          cohort_website = registry_cohort$cohort_website,
          cohort_type = cohort_type,
          output_dir = output_dir
        )
      },
      error = function(e) {
        cli::cli_inform(
          c(
            "x" = "Unable to create certificate for {.val {paste(first_name, last_name)}}",
            "i" = paste("  Error:", e$message)
          )
        )
      }
    )
  }

  output_dir
}


# Ideas for my original approach before Nick Tierney's help

# kyber::call_agenda(
#   registry_url = "https://docs.google.com/spreadsheets/d/1Ys9KiTXXmZ_laBoCV2QWEm7AcnGSVQaXvm2xpi4XTSc/edit#gid=942365997",
#   cohort_id = "2022-nasa-champions",
#   call_number = 3)

# kyber_function(registry, ParticpantsList) %>%
# kyber::create_certificate <- function(registry, ParticpantsList) %>%

# 1. Read cohort_metadata from OpenscapesChampionsCohortRegistry gsheet
# Get values of these variables about the Cohort
# cohort_name_long
# cohort_website
# date_start to date_end
#
# 2. Get participant names from OpenscapesParticipantsMainList sheet
# Approach 1: copy names from sheet and use datapasta to paste as tribble, analogous to generating name.md files for GitHub Clinic
# library(stringr)
# library(datapasta) # install.packages("datapasta")
# library(kyber) ## remotes::install_github("openscapes/kyber")
# library(here)
# library(fs)
#
# ## use `datapasta` addin to vector_tribble these names formatted from the spreadsheet!
# cohort <- c(tibble::tribble(
#   ~first,             ~last,
#   "_demo",       "",
#   "Erin",        "Robinson",
#   "Julie",         "Lowndes"
# )
# )
#
# ## create .md files for each Champion
# kyber::short_names(cohort$first, cohort$last) |>
#   create_github_clinic(here())


# Output as pdfs named openscapes_certificate_name.pdf, one per participant

# Upload pdfs to Cohort Folder

# In Closing of Final Cohort Call, add "get your certificate" and point to folder location
