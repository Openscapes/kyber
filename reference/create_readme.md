# Create a README.Rmd from a Kyber Template

Create a README.Rmd from a Kyber Template

## Usage

``` r
create_readme(
  file = "README.Rmd",
  template = "openscapes-cohort-readme",
  cohort_name = basename(getwd()),
  edit = TRUE
)
```

## Arguments

- file:

  File name for the draft

- template:

  Template to use as the basis for the draft. This is either the full
  path to a template directory or the name of a template directory
  within the `rmarkdown/templates` directory of a package.

- cohort_name:

  The name of the cohort. Defaults to the current working directory
  name.

- edit:

  `TRUE` to edit the template immediately

## Details

Valid values for the `template` argument include
`"openscapes-cohort-readme"`.

## Examples

``` r
if (FALSE) { # \dontrun{

kyber::create_readme()
} # }
```
