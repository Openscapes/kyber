#' @importFrom dplyr filter tibble arrange pull
readme_setup <- function(params){
  occr <- get_registry(params$cohort_registry)
  cr <- occr$cohort_metadata %>% 
    filter(cohort_name == params$cohort_name)
  
  date_start <- cr$date_start %>% usa_date_to_iso8601()
  date_end <- cr$date_end %>% usa_date_to_iso8601()
  date_range <- seq.Date(date_start, date_end, by = "2 weeks")
  schedule <- tibble(
    Date = fmt_schedule_dates(date_range),
    "Cohort Call Topics" = occr$call_metadata %>% 
      filter(!is.na(call)) %>% 
      arrange(call) %>% 
      pull(title)
  )
  
  list(cr = cr, date_start = date_start, date_end = date_end, 
       date_range = date_range, schedule = schedule)
}