#' Render certificates of completion for a participant in a cohort
#'
#' @param cohort_name The name of the cohort
#' @param participant_name The name of the participant
#' @param start_date cohort start date
#' @param end_date cohort end date
#' @param cohort_website cohort website
#' @param output_dir output directory for certificates. Default `"."`
#'
#' @return Saves the file to your current working directory, and 
#'   returns the path to the file
#' @export
#'
#' @examples
#' \dontrun{
#' render_certificate(cohort_name = "2023-fred-hutch",
#'                    participant_name = "Name",
#'                    start_date = "Sep 19",
#'                    end_date = "Oct 19",
#'                    cohort_website = "https://openscapes.github.io/2023-fred-hutch/")
#' }
render_certificate <- function(cohort_name, 
                               participant_name,
                               start_date, 
                               end_date,
                               cohort_website, 
                               output_dir = ".") {
  # adapted from https://bookdown.org/yihui/rmarkdown/params-knit.html
    
  rmarkdown::render(
    system.file("certificate/certificate.Rmd",package = "kyber"), 
    params = list(
      cohort_name = cohort_name, 
      participant_name = participant_name, 
      start_date = start_date, 
      end_date = end_date, 
      cohort_website = cohort_website
    ),
    output_format = "pdf_document",
    output_file = paste0(
      "OpenscapesCertificate",
      "_",
      cohort_name,
      "_",
      participant_name,
      ".pdf"
    ),
    output_dir = output_dir
  )
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
