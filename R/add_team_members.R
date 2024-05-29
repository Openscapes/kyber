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
