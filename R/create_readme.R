#' Create a README.Rmd from a Kyber Template
#' 
#' @inheritParams rmarkdown::draft
#' @param cohort_name The name of the cohort. Defaults to the current working directory name.
#' @importFrom rmarkdown draft
#' @importFrom rstudioapi hasFun navigateToFile
#' @export
#' @details
#' Valid values for the `template` argument include `"openscapes-cohort-readme"`.
#' @examples
#' \dontrun{
#'
#' kyber::create_readme()
#' }
create_readme <- function(file = "README.Rmd", 
                          template = "openscapes-cohort-readme", 
                          cohort_name = basename(getwd()),
                          edit = TRUE) {
  readme <- rmarkdown::draft(
    file,
    template,
    "kyber",
    create_dir = FALSE,
    edit = FALSE
  )

  readme_text <- readLines(readme)
  readme_text <- whisker::whisker.render(readme_text, list(cohort_name = cohort_name))
  writeLines(readme_text, readme)
  
  file.copy(system.file("agendas", "horst-champions-trailhead.png", package = "kyber"), 
            dirname(file))
  
  if (edit) {
    if (rstudioapi::hasFun("navigateToFile"))
      rstudioapi::navigateToFile(readme)
    else
      utils::file.edit(readme)
  }
  
  invisible(readme)
}
