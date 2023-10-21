## load libraries ----

library(googlesheets4)
# library(here)
library(tidyverse)
library(lubridate)

## load data ----
## successfully uses googlesheets4 pkg to get data frames from these two sheets
registry <- read_sheet("https://docs.google.com/spreadsheets/d/1Ys9KiTXXmZ_laBoCV2QWEm7AcnGSVQaXvm2xpi4XTSc")
participants <- read_sheet("https://docs.google.com/spreadsheets/d/10ub0NKrPa1phUa_X-Jxg8KYH57WGLaZzBN-vQT4e10o")

## define function ----
# adapted from https://bookdown.org/yihui/rmarkdown/params-knit.html
render_certificate = function(cohort_name, 
                              participant_name,
                              start_date, 
                              end_date,
                              cohort_website) {
  
  rmarkdown::render(
    "inst/certificate/certificate.Rmd", params = list(
      cohort_name = cohort_name, 
      participant_name = participant_name, 
      start_date = start_date, 
      end_date = end_date, 
      cohort_website = cohort_website
    ),
    #    output_format = "pdf_document",
    output_file = paste0("OpenscapesCertificate", "_", cohort_name, "_", participant_name, ".html")
  )
}


## code with fixed values we used to test rendering a certificate using participant_name_first and participant_name_last
## comment out when doing the real thing
# render_certificate(cohort_name = "2023-fred-hutch",
#                    participant_name = "Name",
#                    start_date = "Sep 19",
#                    end_date = "Oct 19",
#                    cohort_website = "https://openscapes.github.io/2023-fred-hutch/")
# 


## call function ----

## subset data: `registry` and `participants` where Cohort is 2023-fred-hutch
registry_cohort <-filter(registry, cohort_name=="2023-fred-hutch")
participants_cohort <-filter(participants, cohort=="2023-fred-hutch")

## Loop through each participant in list and create certificate for each
participant_name <- participants_cohort$last

for (p_name in participant_name) {

  render_certificate(cohort_name = registry_cohort$cohort_name,
                     start_date = registry_cohort$date_start,
                     end_date = registry_cohort$date_end,
                     cohort_website = registry_cohort$cohort_website,
                     participant_name = p_name
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
