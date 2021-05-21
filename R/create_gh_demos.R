#' Create GitHub Demo Functions
#'
#' @param cohort 
#'
#' @return
#' @export
#'
#' @examples

create_gh_demo_pub <- function(cohort) {
  
  for (champion in cohort) {
    
    cohort <- str_to_lower(cohort)
    
    file_out <- glue::glue(champion, ".md")
    text_write <- write_lines(text_template, file_out)
    
    ## TODO: testthat to add lastname initials if there is a repeat firstname
    
  } 
}


