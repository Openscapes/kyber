#' Add GitHub Users to a Team
#'
#' @param team The name of the team.
#' @param members A vector of GitHub usernames.
#' @param org The GitHub organization that owns the team and the repository.
#' @importFrom purrr map safely map_lgl
#' @export
#' @examples
#' \dontrun{
#'
#' kyber::add_team_members("2021-ilm-rotj-team", members = c("erinmr", "seankross"))
#' }
add_team_members <- function(team, members, org = "openscapes"){
  check_gh_pat()
  
  if(!identical(members, gsub("\\s", "", members))){
    stop("GitHub usernames: ", paste0("'", members[grep("\\s", members)], "'"), " must not contain any whitespace.")
  }
  
  responses <- members %>% 
    map(safely(~gh("/users/{username}", username = .x)))
  
  invalid_usernames <- responses %>% map_lgl(~is.null(.x$"result"))
  if(any(invalid_usernames)){
    warning("GitHub username(s): ", members[invalid_usernames], " do(es) not exist.")
  }
  
  # All usernames are invalid
  if(sum(invalid_usernames) == length(invalid_usernames)){
    return(invisible(responses))
  }
  
  members <- members[!invalid_usernames]
  
  responses <- list()  
  for (i in seq_along(members)) {
    responses[[i]] <- gh("PUT /orgs/{org}/teams/{team_slug}/memberships/{username}",
                         org = org, team_slug = team, 
                         username = members[i], role = "member")
  }
  invisible(responses)
}

#' List members of a GitHub Team
#'
#' @inheritParams add_team_members
#' @param names_only Should only the team member names be returned (as a character vector; `TRUE`, the default),
#'     or should all of the team member metadata be returned?
#' @param ... passed on to [gh::gh()]
#'
#' @return a character vector of team member GitHub usernames if `names_only = TRUE`, otherwise
#'    a `gh_response` object containing team member information
#' @export
#'
#' @examples
#' \dontrun{
#'   list_team_members(team = "2023-superdogs-test-cohort", org = "openscapes")
#'   list_team_members(team = "2023-superdogs-test-cohort", org = "openscapes", names_only = FALSE)
#' }
list_team_members <- function(team, org = "openscapes", names_only = TRUE, ...) {
  check_gh_pat()

  org_teams <- list_teams(org)

  if (!team %in% org_teams) {
    stop("'", team, "' is not part of the '", org, "' organization", 
         call. = FALSE)
  }

  team_members <- gh(
    "GET /orgs/{org}/teams/{team_slug}/members",
    org = org,
    team_slug = team,
    ...
  )

  if (!names_only) return(team_members)
    
  vapply(team_members, `[[`, FUN.VALUE = character(1), "login")
}
  
#' List teams in a GitHub organization
#'
#' @inheritParams list_team_members
#' @param names_only Should only the team names be returned (as a character vector; `TRUE`, the default),
#'     or should all of the team metadata be returned?
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
    
  teams <- gh("GET /orgs/{org}/teams", org = org)
  
  if (!names_only) return(teams)

  vapply(teams, `[[`, FUN.VALUE = character(1), "name")
}
