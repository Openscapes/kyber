#' List members of a GitHub Team
#'
#' @inheritParams add_team_members
#' @param names_only Should only the team member names be returned (as a
#'   character vector; `TRUE`, the default), or should all of the team member
#'   metadata be returned as a data.frame?
#' @param members Should current members (`"members"`) be returned, or pending
#'   invitations (`"invitations"`) invitations be returned? Default `"members"`.
#' @param ... passed on to [gh::gh()]
#'
#' @return a character vector of team member GitHub usernames if `names_only =
#'   TRUE`, otherwise a `gh_response` object containing team member information
#' @export
#'
#' @examples
#' \dontrun{
#'   list_team_members(team = "2023-superdogs-test-cohort", org = "openscapes")
#'   list_team_members(team = "2023-superdogs-test-cohort", org = "openscapes", 
#'                     names_only = FALSE)
#'   list_team_members(team = "2023-superdogs-test-cohort", org = "openscapes", 
#'                     members = "invitations")
#' }
list_team_members <- function(team, org = "openscapes", names_only = TRUE, 
                              members = c("members", "invitations"), ...) {
  check_gh_pat()

  team <- tolower(team)
  org <- tolower(org)
  org_teams <- list_teams(org, names_only = FALSE)
  members <- match.arg(members)

  if (!team %in% org_teams$slug) {
    stop("'", team, "' is not part of the '", org, "' organization", 
         call. = FALSE)
  }

  team_members <- gh(
    "GET /orgs/{org}/teams/{team_slug}/{members}",
    org = org,
    team_slug = team,
    members = members,
    ..., 
    .limit = Inf
  )

  if (!names_only) return(dplyr::bind_rows(team_members))
    
  vapply(team_members, `[[`, FUN.VALUE = character(1), "login")
}
  
#' List teams in a GitHub organization
#'
#' @inheritParams list_team_members
#' @param names_only Should only the team names be returned (as a character vector; `TRUE`, the default),
#'     or should all of the team metadata be returned as a data frame?
#'
#' @return a character vector of team names if `names_only = TRUE`, otherwise
#'    a `gh_response` object containing team information
#' @export
#'
#' @examples
#' \dontrun{
#'   list_teams(org = "openscapes")
#'   list_teams(org = "openscapes", names_only = FALSE)
#' }
list_teams <- function(org = "openscapes", names_only = TRUE, ...) {
  check_gh_pat()
    
  teams <- gh("GET /orgs/{org}/teams", org = org, ..., .limit = Inf) %>%
    purrr::map(function(x) {
      if(!is.null(x[["parent"]])) {
        x[["parent"]] <- x[["parent"]][["name"]]
      }
      x
    })
  
  if (!names_only) return(dplyr::bind_rows(teams))

  vapply(teams, `[[`, FUN.VALUE = character(1), "name")
}
