# Render certificates of completion for a participant in a cohort

Render certificates of completion for a participant in a cohort

## Usage

``` r
create_certificate(
  cohort_name = NULL,
  first_name = NULL,
  last_name = NULL,
  start_date = NULL,
  end_date = NULL,
  cohort_website = NULL,
  cohort_type = c("standard", "nmfs", "pathways"),
  output_dir = ".",
  quiet = TRUE,
  ...
)
```

## Arguments

- cohort_name:

  The name of the cohort

- first_name:

  First name of participant

- last_name:

  Last name of participant

- start_date:

  cohort start date. `Date` or character in a standard format (eg.,
  YYYY-MM-DD)

- end_date:

  cohort end date. `Date` or character in a standard format (eg.,
  YYYY-MM-DD)

- cohort_website:

  cohort website URL.

- cohort_type:

  What kind of cohort are the certificates for? This will choose the
  appropriate certificate template: `"standard"` (default), `"nmfs"`, or
  \`"pathways"“.

- output_dir:

  output directory for certificates. Default `"."`

- quiet:

  Suppress quarto warnings and other messages. Default `TRUE`. Set to
  `FALSE` to help debug if any errors occur.

- ...:

  Other parameters passed on to
  [`quarto::quarto_render()`](https://quarto-dev.github.io/quarto-r/reference/quarto_render.html)

## Value

Saves the file to the specified directory, and returns the path to the
file

## Examples

``` r
if (FALSE) { # \dontrun{
create_certificate(
  cohort_name = "2023-fred-hutch",
  first_name = "FirstName",
  last_name = "LastName",
  start_date = "2023-09-19",
  end_date = "2023-10-19",
  cohort_website = "https://openscapes.github.io/2023-fred-hutch/",
  cohort_type = "standard"
)
} # }
```
