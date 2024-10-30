#' Check the duration of call
#' 
#' @inheritParams call_agenda
#' @importFrom cli cli_alert_info
#' @export
check_duration <- function(registry_url, cohort_id, call_number,
                           cohort_sheet = "cohort_metadata", 
                           call_sheet = "call_metadata"){
  cohort_registry <- read_sheet(registry_url, cohort_sheet, col_types = "c")
  call_registry <- read_sheet(registry_url, call_sheet, col_types = "c")
  
  cohort_type_ <- get_cohort_type(cohort_registry, cohort_id)
  template_files <- get_template_files(call_registry, call_number, cohort_type_)
  
  warn_if_any_not_rmd(template_files)
  stop_if_any_templates_not_installed(template_files)
  
  template_files <- template_files %>% 
    map_chr(kyber_file)
  
  template_params <- template_files %>% 
    map(yaml_front_matter) %>% 
    map(~.x$params)
  
  durations <- template_params %>% 
    map_dbl(~ ifelse(is.null(.x$duration), NA, .x$duration))
  
  total_duration <- template_params %>% 
    map_dbl(~ ifelse(is.null(.x$total_duration), NA, .x$total_duration))
  
  paste("Specified total duration:", 
        (list_flatten(template_params))$total_duration, "minutes") %>%
    cli_alert_info()
  paste("Calculated total duration:", 
        sum(durations, na.rm = TRUE), "minutes") %>%
    cli_alert_info()
  invisible()
}
