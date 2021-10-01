#' Add GitHub Users to a Team
#'
#' @param team The name of the team.
#' @param members A vector of GitHub usernames.
#' @param org The GitHub organization that owns the team and the repository.
#' @importFrom gh gh
#' @export
#' @examples
#' \dontrun{
#'
#' kyber::ky_add_team_members("2021-ilm-rotj-team", members = c("erinmr", "seankross"))
#' }
ky_add_team_members <- function(team, members, org = "openscapes"){
  check_gh_pat()
  
  responses <- list()  
  for (i in seq_along(members)) {
    responses[[i]] <- gh("PUT /orgs/{org}/teams/{team_slug}/memberships/{username}",
                         org = org, team_slug = team, 
                         username = members[i], role = "member")
  }
  invisible(responses)
}