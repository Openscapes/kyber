#' @importFrom dplyr filter tibble arrange pull
#' @importFrom cli cli_abort
readme_setup <- function(params) {
  occr <- get_registry(params$cohort_registry)

  if (!(params$cohort_name %in% occr$cohort_metadata$cohort_name)) {
    cli_abort(
      "{params$cohort_name} not found in cohort registry. Check README.Rmd yaml frontmatter."
    )
  }

  cr <- occr$cohort_metadata %>%
    filter(cohort_name == params$cohort_name)

  date_start <- cr$date_start %>% usa_date_to_iso8601()
  date_end <- cr$date_end %>% usa_date_to_iso8601()
  date_range <- seq.Date(date_start, date_end, by = "2 weeks")
  schedule <- tibble(
    Date = fmt_schedule_dates(date_range),
    "Cohort Call Topics" = occr$call_metadata %>%
      filter(!is.na(call)) %>%
      filter(cohort_type == cr$cohort_type) %>%
      arrange(call) %>%
      pull(title)
  )

  list(
    cr = cr,
    date_start = date_start,
    date_end = date_end,
    date_range = date_range,
    schedule = schedule
  )
}
