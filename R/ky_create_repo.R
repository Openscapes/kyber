#' Create a GitHub repository with a README.Rmd
#' 
#' @inheritParams rmarkdown::draft
#' @param name The name of the repository.
#' @param org The GitHub organization that will own the repository.
#' @param path The path to a directory where the repository will be created.
#' 
#' @importFrom fs path dir_create file_copy
#' @importFrom gert git_clone
#' @importFrom gh gh
#' @export
#' @details
#' Valid values for the `template` argument include `"openscapes-cohort-readme"`,
#' or `FALSE` if you want to create a repository with no `README.md`.
#' @examples
#' \dontrun{
#'
#' kyber::ky_create_repo("2021-ilm-rotj")
#' }
ky_create_repo <- function(name, org = "openscapes", path = getwd(),
                           template = "openscapes-cohort-readme", edit = TRUE){
  check_gh_pat()
  
  response <- gh("POST /orgs/{org}/repos", org = org, name = name)
  repo_path <- gert::git_clone(response$html_url, path = fs::path(path, name))
  
  if(!isFALSE(template)) {
    ky_create_readme(
      fs::path(repo_path, "README.Rmd"),
      template,
      edit = edit
    )
  }
  
  invisible(repo_path)
}