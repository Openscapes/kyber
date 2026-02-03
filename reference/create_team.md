# Create a Team on GitHub for an Organization

Create a Team on GitHub for an Organization

## Usage

``` r
create_team(name, maintainers, org = "openscapes", visible = TRUE)
```

## Arguments

- name:

  The name of the team.

- maintainers:

  One or more GitHub usernames that will be the team maintainers.

- org:

  The GitHub organization that will own the team.

- visible:

  Should the team be visible to every member of the organization?

## Examples

``` r
if (FALSE) { # \dontrun{

# One maintainer
kyber::create_team("2021-ilm-rotj-team", maintainers = "jules32")

# Multiple maintainers
kyber::create_team("2021-ilm-rotj-team", maintainers = c("jules32", "seankross"))
} # }
```
