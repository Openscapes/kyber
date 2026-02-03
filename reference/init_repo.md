# Initialize a GitHub repository with a README.Rmd

Initialize a GitHub repository with a README.Rmd

## Usage

``` r
init_repo(
  name,
  org = "openscapes",
  path = getwd(),
  template = "openscapes-cohort-readme",
  edit = TRUE
)
```

## Arguments

- name:

  The name of the GitHub repository.

- org:

  The GitHub organization that will own the repository.

- path:

  The path to a directory where the repository will be initialized.

- template:

  Template to use as the basis for the draft. This is either the full
  path to a template directory or the name of a template directory
  within the `rmarkdown/templates` directory of a package.

- edit:

  `TRUE` to edit the template immediately

## Details

Valid values for the `template` argument include
`"openscapes-cohort-readme"`, or `FALSE` if you want to create a
repository with no `README.md`.

## Examples

``` r
if (FALSE) { # \dontrun{

kyber::init_repo("2021-ilm-rotj")
} # }
```
