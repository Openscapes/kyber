#' Render certificates of completion for a participant in a cohort
#'
#' @param cohort_name The name of the cohort
#' @param first_name First name of participant
#' @param last_name Last name of participant
#' @param start_date cohort start date. `Date` or character in a standard format
#'     (eg., YYYY-MM-DD)
#' @param end_date cohort end date. `Date` or character in a standard format
#'     (eg., YYYY-MM-DD)
#' @param cohort_website cohort website URL.
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
  cohort_name = NULL,
  first_name = NULL,
  last_name = NULL,
  start_date = NULL,
  end_date = NULL,
  cohort_website = NULL,
  cohort_type = c("standard", "nmfs", "pathways"),
  output_dir = ".",
  quiet = TRUE,
  ...
) {
  # adapted from https://bookdown.org/yihui/rmarkdown/params-knit.html

  cohort_type <- match.arg(cohort_type)

  start_date <- as.Date(start_date)
  end_date <- as.Date(end_date)

  template <- switch(
    cohort_type,
    standard = system.file("certificate/certificate.qmd", package = "kyber"),
    nmfs = system.file("certificate/certificate-nmfs.qmd", package = "kyber"),
    pathways = system.file(
      "certificate/certificate-pathways.qmd",
      package = "kyber"
    )
  )

  participant_name <- paste(first_name, last_name)

  outfile <- paste0(
    ifelse(
      cohort_type == "pathways",
      paste0(
        "Certificate_",
        cohort_name %||% "Pathways-to-Open-Science",
        "-",
        lubridate::year(start_date)
      ),
      paste0("OpenscapesCertificate_", cohort_name)
    ),
    "_",
    participant_name,
    ".pdf"
  )

  outfile <- gsub("\\s+", "-", outfile)

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
  cohort_type = c("standard", "nmfs"),
  output_dir = "."
) {
  if (!cohort_name %in% registry$cohort_name) {
    stop("'cohort_name' is not a cohort in 'registry_sheet'", call. = FALSE)
  }

  if (!cohort_name %in% participants$cohort) {
    stop("'cohort_name' is not a cohort in 'participants'", call. = FALSE)
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

#' Create batch certificates for Pathways participants
#'
#' @param participants A data frame with a column 'participant_name' containing full names of participants.
#' @param cohort_name Name of the cohort; default `"Pathways to Open Science"`
#' @inheritParams create_certificate
#'
#' @returns
#' The path to the output directory. Individual certificate creation failures
#' will be reported but won't stop the batch process.
#'
#' @export
create_batch_pathways_certificates <- function(
  participants,
  start_date,
  end_date,
  cohort_name = "Pathways to Open Science",
  output_dir = ".",
  ...
) {
  start_date <- as.Date(start_date)
  end_date <- as.Date(end_date)

  participant_names <- get_participant_names(participants)

  dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

  for (name in participant_names) {
    tryCatch(
      {
        first_name <- name[1]
        last_name <- name[2]

        create_certificate(
          cohort_name = cohort_name,
          first_name = first_name,
          last_name = last_name,
          start_date = start_date,
          end_date = end_date,
          cohort_type = "pathways",
          output_dir = output_dir
        )
      },
      error = function(e) {
        cli::cli_inform(
          c(
            "x" = "Unable to create certificate for {.val {name}}",
            "i" = paste("  Error:", e$message)
          )
        )
      }
    )
  }

  output_dir
}

get_participant_names <- function(participants) {
  UseMethod("get_participant_names")
}

#' @export
get_participant_names.character <- function(participants) {
  stringr::str_split(
    participants,
    "\\s+",
    n = 2
  )
}

#' @export
get_participant_names.data.frame <- function(participants) {
  if ("participant_name" %in% names(participants)) {
    get_participant_names(participants[["participant_name"]])
  } else {
    if (length(participants) == 1) {
      cli::cli_warn(
        "Did not find a {.val participant_name} column in the {.val participants} 
        data.frame, but there is one column named {.val {names(participants)}}. 
        Using that column."
      )
      get_participant_names(participants[[1]])
    } else {
      cli::cli_abort(
        "There should be a single column called {.val participant_name} in the {.val participants} data.frame",
      )
    }
  }
}
