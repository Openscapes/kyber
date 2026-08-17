# Create a Call Agenda

Create a Call Agenda

## Usage

``` r
call_agenda(
  registry_url,
  cohort_id,
  call_number,
  cohort_sheet = "cohort_metadata",
  call_sheet = "call_metadata",
  website = paste0("https://openscapes.github.io/", cohort_id),
  output_format = md_agenda(),
  output_file = paste0("agenda_call_", call_number, ".md")
)
```

## Arguments

- registry_url:

  The URL to the cohort registry.

- cohort_id:

  The ID of the cohort.

- call_number:

  The call number of the agenda.

- cohort_sheet:

  The sheet in the registry with cohort information.

- call_sheet:

  The sheet in the registry with information about individual calls.

- website:

  A website for the cohort.

- output_format:

  The output format of the agenda.

- output_file:

  The name of the output file. Defaults to
  `"agenda_call_[call_number].md"`.
