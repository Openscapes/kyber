#' Create GitHub Demo Functions
#'
#' @param cohort 
#'
#' @return
#' @export
#'
#' @example call: create_github_demo_pub("2021-sasi")

create_github_repo <- function(cohort, coc=TRUE) {
  ## TODO:
  # create a GH repo
  # populate with Code of Conduct as an .md, pull from https://github.com/Openscapes/website/blob/master/content/code-of-conduct.md
  # create README.md from template
  }

create_github_clinic <- function(cohort) {
  
  ## TODO: 
  ## read in cohort fullnames from Airtable, perhaps with airtableR, https://itsalocke.com/blog/how-to-use-an-r-interface-with-airtable-api/
  ## create `github-clinic` folder for each filename
  
  for (champion in cohort) {
    
    cohort <- str_to_lower(cohort)
    
    file_out <- glue::glue(champion, ".md")
    text_write <- write_lines(github_clinic_md_text, file_out)
    
    ## TODO: testthat to add lastname initials if there is a repeat firstname.
    
  } 
}

github_team_permissions <- function(cohort) {
  ## TODO:
  ## add everyone to a team with the name of the cohort
  ## give them editing privileges for their cohort repo
}
