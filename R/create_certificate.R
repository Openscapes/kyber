# copied from https://bookdown.org/yihui/rmarkdown/params-knit.html
# render_report = function(region, year) {
#   rmarkdown::render(
#     "MyDocument.Rmd", params = list(
#       region = region,
#       year = year
#     ),
#     output_file = paste0("Report-", region, "-", year, ".pdf")
#   )
# }

# adapted from https://bookdown.org/yihui/rmarkdown/params-knit.html
render_certificate = function(cohort_name, 
                              particpant_name, 
                              start_date, 
                              end_date, 
                              year, 
                              cohort_website) {
  rmarkdown::render(
    "inst/certificate/certificate.Rmd", params = list(
      cohort_name = cohort_name, 
      particpant_name = particpant_name, 
      start_date = start_date, 
      end_date = end_date, 
      year = year, 
      cohort_website = cohort_website
    ),
#    output_format = "pdf_document",
    output_file = paste0("certificate-", particpant_name, "-", cohort_name, ".html")
  )
}

render_certificate(cohort_name = "2023-fred-hutch",
                   particpant_name = "patty",
                   start_date = "Sep 19",
                   end_date = "Oct 19",
                   year = "2023",
                   cohort_website = "https://openscapes.github.io/2023-fred-hutch/")


# next steps
# certificate_csv <- read_csv("google-drive-link-thingy")
# 
# render_certificate(cohort_name = certificate_csv$cohort_name,
#                    particpant_name = certificate_csv$particpant_name,
#                    start_date = certificate_csv$start_date,
#                    end_date = certificate_csv$end_date,
#                    year = certificate_csv$year,
#                    cohort_website = certificate_csv$cohort_website)









# kyber::call_agenda(
#   registry_url = "https://docs.google.com/spreadsheets/d/1Ys9KiTXXmZ_laBoCV2QWEm7AcnGSVQaXvm2xpi4XTSc/edit#gid=942365997", 
#   cohort_id = "2022-nasa-champions", 
#   call_number = 3)

library(kyber) 
library(rmarkdown)
library(tibble)
library(fs)
# library(datapasta)
# library(here)

# kyber_function(registry, ParticpantsList) %>%

kyber::create_certificate <- function(registry, ParticpantsList) %>%

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




kyber::create_certificate(
  registry_url = "https://docs.google.com/spreadsheets/d/1Ys9KiTXXmZ_laBoCV2QWEm7AcnGSVQaXvm2xpi4XTSc/edit#gid=695033382", 
  cohort_id = "2023-fred-hutch",
  particpants_url = ??)