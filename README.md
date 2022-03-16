# kyber

<!-- badges: start -->
[![R-CMD-check](https://github.com/Openscapes/kyber/workflows/R-CMD-check/badge.svg)](https://github.com/Openscapes/kyber/actions)
<!-- badges: end -->

Tools for setting up learning cohorts on GitHub, inspired by the Openscapes
Champions Program.

## Installation

You can install Kyber using the `remotes` package:

``` r
remotes::install_github("openscapes/kyber@main")
```

## Example Workflow

### GitHub Repos

Kyber requires you to set up a GitHub Personal Access Token with scopes for 
**repo** and **admin:org**. See the [GitHub PAT documentation][gh-pat-docs] for 
more information about how to generate your PAT. Please make sure that you do
not share your PAT or commit it to a Git repository, since anyone with your PAT
can act as you on GitHub.

``` r
# First make sure to set your GitHub PAT
Sys.setenv(GITHUB_PAT = "ghp_4X73I5ACF1JWZY92STBE") # must do this each R session

library(kyber) 
library(rmarkdown)
library(tibble)
library(fs)

members <- tribble(
  ~First, ~Last,      ~Username,
  "Erin", "Robinson", "erinmr",
  "Sean", "Kross",    "seankross"
)

repo_name <- "2021-ilm-rotj"
team_name <- paste0(repo_name, "-team")

# This will open a README.Rmd for you to edit
repo_path <- ky_create_repo(repo_name)

# Then render the README.Rmd to README.md
render(path(repo_path, "README.Rmd"))

ky_short_names(members$First, members$Last) |>
  ky_create_github_clinic(repo_path)

# We still need to work out the next part of the workflow and the extent to
# which it should be automated, but I imagine something like:
#
# 1. Move README.Rmd out of this repository to another repository that perhaps 
# only contains README.Rmds.
# 2. Git add, commit, and push in the repo that only contains README.Rmds.
# 3. Git add, commit, and push in this repository.

ky_create_team(team_name, maintainers = "jules32")
ky_add_team_members(team_name, members = members$Username)
ky_add_repo_to_team(repo_name, team_name)
```

### Agendas

```
kyber::call_agenda(
    registry_url = "https://docs.google.com/spreadsheets/d/1Oej46BMX_SLIc1cwoyLHzNWwGlT3szez8FDKc3b418w/edit#gid=942365997", 
    cohort_id = "2022-nasa-champions", 
    call_number = 12)
```

### Other
[gh-pat-docs]:https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
