# Create batch certificates for Pathways participants

Create batch certificates for Pathways participants

## Usage

``` r
create_batch_pathways_certificates(
  participants,
  start_date,
  end_date,
  cohort_name = "Pathways to Open Science",
  output_dir = ".",
  ...
)
```

## Arguments

- participants:

  A data frame with a column 'participant_name' containing full names of
  participants.

- start_date:

  cohort start date. `Date` or character in a standard format (eg.,
  YYYY-MM-DD)

- end_date:

  cohort end date. `Date` or character in a standard format (eg.,
  YYYY-MM-DD)

- cohort_name:

  Name of the cohort; default `"Pathways to Open Science"`

- output_dir:

  output directory for certificates. Default `"."`

- ...:

  Other parameters passed on to
  [`quarto::quarto_render()`](https://quarto-dev.github.io/quarto-r/reference/quarto_render.html)

## Value

The path to the output directory. Individual certificate creation
failures will be reported but won't stop the batch process.

## Examples

``` r
if (FALSE) { # \dontrun{
participants <- read_csv("zoom-participants.csv")

create_batch_pathways_certificates(
  participants,
  start_date = "2024-01-01",
  end_date = "2024-02-01",
  "~/Desktop/pathways-certificates"
)
} # }
```
