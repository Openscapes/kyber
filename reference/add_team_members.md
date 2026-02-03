# Add GitHub Users to a Team

This also adds them to the organization that contains the team. All
users will get an invitation by email and on GitHub.com, that they need
to accept. This invitation expires after seven days.

## Usage

``` r
add_team_members(team, members, org = "openscapes")
```

## Arguments

- team:

  The name of the team.

- members:

  A vector of GitHub usernames.

- org:

  The GitHub organization that owns the team and the repository.

## Value

list of responses from the GitHub API

## Examples

``` r
if (FALSE) { # \dontrun{
add_team_members("2021-ilm-rotj-team", members = c("not-ateucher", "seankross"))
} # }
```
