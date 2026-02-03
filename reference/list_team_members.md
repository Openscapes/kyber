# List members of a GitHub Team

List members of a GitHub Team

## Usage

``` r
list_team_members(
  team,
  org = "openscapes",
  names_only = TRUE,
  members = c("members", "invitations"),
  ...
)
```

## Arguments

- team:

  The name of the team.

- org:

  The GitHub organization that owns the team and the repository.

- names_only:

  Should only the team member names be returned (as a character vector;
  `TRUE`, the default), or should all of the team member metadata be
  returned as a data.frame?

- members:

  Should current members (`"members"`) be returned, or pending
  invitations (`"invitations"`) invitations be returned? Default
  `"members"`.

- ...:

  passed on to [`gh::gh()`](https://gh.r-lib.org/reference/gh.html)

## Value

a character vector of team member GitHub usernames if
`names_only = TRUE`, otherwise a `gh_response` object containing team
member information

## Examples

``` r
if (FALSE) { # \dontrun{
  list_team_members(team = "2023-superdogs-test-cohort", org = "openscapes")
  list_team_members(team = "2023-superdogs-test-cohort", org = "openscapes",
                    names_only = FALSE)
  list_team_members(team = "2023-superdogs-test-cohort", org = "openscapes",
                    members = "invitations")
} # }
```
