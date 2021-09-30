#' Create a README.Rmd from a Kyber Template
#' 
#' @inheritParams rmarkdown::draft
#' 
#' @importFrom rmarkdown draft
#' @importFrom rstudioapi hasFun navigateToFile
#' @export
#' @details
#' Valid values for the `template` argument include `"openscapes-cohort-readme"`.
#' @examples
#' \dontrun{
#'
#' kyber::ky_create_readme()
#' }
ky_create_readme <- function(file = "README.Rmd", 
                             template = "openscapes-cohort-readme", edit = TRUE){
  readme <- rmarkdown::draft(
    file,
    template,
    "kyber",
    create_dir = FALSE,
    edit = FALSE
  )
  
  if (edit) {
    if (rstudioapi::hasFun("navigateToFile"))
      rstudioapi::navigateToFile(readme)
    else
      utils::file.edit(readme)
  }
  
  invisible(readme)
}