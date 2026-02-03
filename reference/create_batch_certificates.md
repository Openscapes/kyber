# Render a batch of certificates for a Champions Cohort

Given a data.frame of Champions participants and a Cohort registry,
create a certificate for each participant

## Usage

``` r
create_batch_certificates(
  registry,
  participants,
  cohort_name,
  cohort_type = c("standard", "nmfs"),
  output_dir = "."
)
```

## Arguments

- registry:

  `data.frame` from Google Sheet of Champions registry
  (`"OpenscapesChampionsCohortRegistry"`)

- participants:

  `data.frame` from Google Sheet of Champions participants
  (`"OpenscapesParticipantsMainList"`)

- cohort_name:

  Name of the cohort as it appears in `registry` and `participants`

- cohort_type:

  What kind of cohort are the certificates for? This will choose the
  appropriate certificate template: `"standard"` (default), `"nmfs"`, or
  \`"pathways"“.

- output_dir:

  output directory for certificates. Default `"."`

## Value

path to the directory containing the certificates

## Examples

``` r
if (FALSE) { # \dontrun{
googlesheets4::gs4_auth()

registry <- googlesheets4::read_sheet("path-to-registry")
participants <- googlesheets4::read_sheet("path-to-participants")

create_batch_certificates(
  registry,
  particpants,
  "2023-fred-hutch",
  "~/Desktop/fred-hutch-certificates"
)
} # }
```
