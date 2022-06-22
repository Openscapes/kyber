#' Initialize a GitHub repository with a README.Rmd
#' 
#' @inheritParams rmarkdown::draft
#' @param name The name of the GitHub repository.
#' @param org The GitHub organization that will own the repository.
#' @param path The path to a directory where the repository will be initialized.
#' 
#' @importFrom fs path dir_create file_copy
#' @importFrom gert git_clone git_init git_add git_commit git_branch git_branch_move git_remote_add git_push
#' @importFrom gh gh
#' @importFrom purrr map_chr
#' @export
#' @details
#' Valid values for the `template` argument include `"openscapes-cohort-readme"`,
#' or `FALSE` if you want to create a repository with no `README.md`.
#' @examples
#' \dontrun{
#'
#' kyber::init_repo("2021-ilm-rotj")
#' }
init_repo <- function(name, org = "openscapes", path = getwd(),
                           template = "openscapes-cohort-readme", edit = TRUE){
  check_gh_pat()
  
  repo_names <- gh("GET /orgs/{org}/repos", org = org) %>% map_chr(~.x$"name")
  if(name %in% repo_names){
    stop("A GitHub repository named ", name,
         " already exists for the ", org, " organization.", call. = FALSE)
  }
  
  response <- gh("POST /orgs/{org}/repos", org = org, name = name)
  repo_initialized <- tryCatch(gert::git_find(path), error = function(e) FALSE)
  
  if(repo_initialized) {
    stop("A local Git repository has already been initialized at ", path,
         " therefore no further Git actions will be taken. ",
         "A GitHub repository was created at ", org, "/", name, ".", 
         call. = FALSE)
  }
  
  git_init(path = path)
  coc_path <- add_code_of_conduct(path = path)
  ignore_path <- add_gitignore(path = path)
  git_add(basename(c(coc_path, ignore_path)), repo = path)
  git_commit(message = "first commit by kyber", repo = path)
  branch_name <- git_branch(repo = path)
  if(branch_name != "main"){
    git_branch_move(branch_name, "main", repo = path)
  }
  git_remote_add(response$"clone_url", repo = path)
  git_push(remote = "origin", set_upstream = TRUE, repo = path)
  
  if(!isFALSE(template)) {
    create_readme(
      fs::path(path, "README.Rmd"),
      template,
      edit = edit
    )
  }
  
  invisible(path)
}