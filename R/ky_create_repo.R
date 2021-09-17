#' Create a Git repository and README.Rmd for a Cohort
#' 
#' @param name The name of the repository.
#' @param org The organization that will own the repository.
#' @param path The path to a directory where the repository will be created.
#' @param edit
#' 
#' @importFrom fs path dir_create file_copy
#' @importFrom gert git_clone
#' @importFrom gh gh
#' @importFrom rmarkdown draft
#' @importFrom rstudioapi hasFun navigateToFile
#' @export
ky_create_repo <- function(name, org = "openscapes", path = getwd(), edit = TRUE){
  response <- gh("POST /orgs/{org}/repos", org = org, name = name)
  repo_path <- gert::git_clone(response$html_url, path = fs::path(path, name))
  
  readme <- rmarkdown::draft(
    fs::path(repo_path, "README.Rmd"),
    "readme",
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
  
  invisible(repo_path)
}