#' Initialize a GitHub repository with a README.Rmd
#'
#' @inheritParams rmarkdown::draft
#' @param name The name of the GitHub repository.
#' @param org The GitHub organization that will own the repository.
#' @param path The path to a directory where the repository will be initialized.
#'
#' @importFrom fs path dir_create file_copy
#' @importFrom gert git_clone git_init git_add git_commit git_branch git_branch_move git_remote_add git_push
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
init_repo <- function(
  name,
  org = "openscapes",
  path = getwd(),
  template = "openscapes-cohort-readme",
  edit = TRUE
) {
  check_gh_pat()

  page <- 1
  rn_growing <- TRUE
  repo_names <- gh(
    "GET /orgs/{org}/repos",
    org = org,
    per_page = 100,
    page = page
  ) %>%
    map_chr(~ .x$"name")

  while (length(repo_names) >= 100 && rn_growing) {
    page <- page + 1
    old_rnl <- length(repo_names)
    repo_names <- gh(
      "GET /orgs/{org}/repos",
      org = org,
      per_page = 100,
      page = page
    ) %>%
      map_chr(~ .x$"name") %>%
      c(repo_names)
    if (old_rnl == length(repo_names)) {
      rn_growing <- FALSE
    }
  }

  if (name %in% repo_names) {
    stop(
      "A GitHub repository named ",
      name,
      " already exists for the ",
      org,
      " organization.",
      call. = FALSE
    )
  }

  repo_path <- path(path, name)

  repo_initialized <- tryCatch(
    gert::git_find(repo_path),
    error = function(e) FALSE
  )
  if (!isFALSE(repo_initialized)) {
    stop(
      "A local Git repository has already been initialized at ",
      path,
      " therefore no further Git actions will be taken.",
      call. = FALSE
    )
  }

  response <- gh("POST /orgs/{org}/repos", org = org, name = name)

  git_init(path = repo_path)
  coc_path <- add_code_of_conduct(path = repo_path)
  ignore_path <- add_gitignore(path = repo_path)
  git_add(basename(c(coc_path, ignore_path)), repo = repo_path)
  git_commit(message = "first commit by kyber", repo = repo_path)
  branch_name <- git_branch(repo = repo_path)
  if (branch_name != "main") {
    git_branch_move(branch_name, "main", repo = repo_path)
  }
  git_remote_add(response$"clone_url", repo = repo_path)
  git_push(remote = "origin", set_upstream = TRUE, repo = repo_path)

  if (!isFALSE(template)) {
    create_readme(
      fs::path(repo_path, "README.Rmd"),
      template,
      cohort_name = name,
      edit = edit
    )
  }

  invisible(repo_path)
}
