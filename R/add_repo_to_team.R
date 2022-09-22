#' Add a GitHub Repository to a Team
#'
#' @param repository The name of the GitHub repository. 
#' @param team The name of the team.
#' @param org The GitHub organization that owns the team and the repository.
#' @importFrom gh gh
#' @export
#' @examples
#' \dontrun{
#'
#' kyber::add_repo_to_team("2021-ilm-rotj", "2021-ilm-rotj-team")
#' }
add_repo_to_team <- function(repository, team, org = "openscapes"){
  check_gh_pat()
  
  response <- gh("PUT /orgs/{org}/teams/{team_slug}/repos/{owner}/{repo}",
                 org, team_slug = team, 
                 owner = org, repo = repository, permission = "push")
  invisible(response)
}