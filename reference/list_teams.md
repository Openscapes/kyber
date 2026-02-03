# List teams in a GitHub organization

List teams in a GitHub organization

## Usage

``` r
list_teams(org = "openscapes", names_only = TRUE, ...)
```

## Arguments

- org:

  The GitHub organization that owns the team and the repository.

- names_only:

  Should only the team names be returned (as a character vector; `TRUE`,
  the default), or should all of the team metadata be returned as a data
  frame?

- ...:

  passed on to [`gh::gh()`](https://gh.r-lib.org/reference/gh.html)

## Value

a character vector of team names if `names_only = TRUE`, otherwise a
`gh_response` object containing team information

## Examples

``` r
if (FALSE) { # \dontrun{
  list_teams(org = "openscapes")
  list_teams(org = "openscapes", names_only = FALSE)
} # }
```
