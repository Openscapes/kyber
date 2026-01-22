#' Add GitHub Users to a Team
#'
#' This also adds them to the organization that contains the team. All users
#' will get an invitation by email and on GitHub.com, that they need to accept.
#' This invitation expires after seven days.
#'
#' @param team The name of the team.
#' @param members A vector of GitHub usernames.
#' @param org The GitHub organization that owns the team and the repository.
#' @importFrom purrr map safely map_lgl
#'
#' @returns list of responses from the GitHub API
#'
#' @export
#' @examples
#' \dontrun{
#' add_team_members("2021-ilm-rotj-team", members = c("not-ateucher", "seankross"))
#' }
add_team_members <- function(team, members, org = "openscapes") {
  resp <- add_remove_team_members_impl_(team, members, org, method = "PUT")
  invisible(resp)
}

#' Remove GitHub Users from a Team
#'
#' @inheritParams add_team_members
#'
#' @returns list of responses from the GitHub API
#'
#' @export
#' @examples
#' \dontrun{
#' remove_team_members("2021-ilm-rotj-team", members = "not-ateucher"))
#' }
remove_team_members <- function(team, members, org = "openscapes") {
  resp <- add_remove_team_members_impl_(team, members, org, method = "DELETE")
  invisible(resp)
}

add_remove_team_members_impl_ <- function(
  team,
  members,
  org,
  method = c("PUT", "DELETE")
) {
  check_gh_pat()

  members <- check_user_names(members)

  # role for default `PUT` method when adding members
  params <- list(role = "member")

  if (method == "DELETE") {
    team_members <- list_team_members(team = team, org = org)
    missing_members <- setdiff(members, team_members)
    if (length(missing_members) == length(members)) {
      cli::cli_abort(
        "None of the specified members are part of the {.val {team}} team"
      )
    }
    if (length(missing_members)) {
      cli::cli_warn(
        "User{cli::qty(missing_members)}{?s} {.val {missing_members}} {?is/are} not part of the {.val {team}} team"
      )
    }
    # No role when removing members, so pass empty list of params
    params <- list()
  }

  responses <- list()

  for (i in seq_along(members)) {
    responses[[i]] <- gh(
      "/orgs/{org}/teams/{team_slug}/memberships/{username}",
      org = org,
      team_slug = team,
      username = members[i],
      .method = method,
      .params = params
    )
  }

  responses
}

#' Remove GitHub organization members
#'
#' @inheritParams add_team_members
#'
#' @returns list of responses from the GitHub API
#'
#' @export
#' @examples
#' \dontrun{
#'  remove_org_members(members = "not-ateucher")
#' }
remove_org_members <- function(members, org = "openscapes") {
  check_gh_pat()

  members <- check_user_names(members)

  responses <- list()

  for (i in seq_along(members)) {
    responses[[i]] <- gh(
      "DELETE /orgs/{org}/members/{username}",
      org = org,
      username = members[i]
    )
  }

  invisible(responses)
}

#' Check usernames and return valid usernames
#'
#' @param members character vector or usernames
#'
#' @returns valid usernames
#' @noRd
check_user_names <- function(members) {
  if (!identical(members, gsub("\\s", "", members))) {
    stop(
      "GitHub usernames: ",
      paste0("'", members[grep("\\s", members)], "'"),
      " must not contain any whitespace."
    )
  }

  responses <- members %>%
    map(safely(~ gh("/users/{username}", username = .x)))

  invalid_usernames <- responses %>% map_lgl(~ is.null(.x$"result"))

  if (any(invalid_usernames)) {
    warning(
      "GitHub username(s): ",
      members[invalid_usernames],
      " do(es) not exist."
    )
  }

  # All usernames are invalid
  if (sum(invalid_usernames) == length(invalid_usernames)) {
    cli::cli_abort("All usernames are invalid")
  }

  members[!invalid_usernames]
}
