#' @import knitr

#' @importFrom gitcreds gitcreds_get
check_gh_pat <- function(){
  gh_pat <- Sys.getenv("GITHUB_PAT")
  if(!nzchar(gh_pat)){
    gh_pat <- gitcreds_get()$"password"
  }
  
  if(!nzchar(gh_pat)) {
    stop("Please set your GITHUB_PAT.", call. = FALSE)
  }
  invisible(TRUE)
}

#' @importFrom stringr str_extract
hm <- function(x) {
  str_extract(x, "([0-1]?[0-9]|2[0-3]):[0-5][0-9]")  
}

am_pm <- function(x) {
  str_extract(x, "\\d{1,2}:\\d{1,2}[apAP][mM]") %>% 
    str_extract("[apAP][mM]")  
}

tz <- function(x) {
  str_extract(x, "\\w*$")
}

tz_long <- function(x) {
  c("ET" = "Eastern Time",
    "CT" = "Central Time",
    "MT" = "Mountain Time",
    "PT" = "Pacific Time")[tz(x)]
}

#' @importFrom lubridate parse_date_time minutes
fmt_duration <- function(start, duration, long_tz = FALSE) {
  start_time <- parse_date_time(start, orders = "%I:%M%p")
  end_time <- start_time + minutes(duration)
  start_time <- sub("am|pm", "", fmt_time(start_time))
  end_time <- fmt_time(end_time)
  end_time <- sub("am", " am", end_time)
  end_time <- sub("pm", " pm", end_time)
  if (long_tz) {
    tz_ <- tz_long(start)
  } else {
    tz_ <- tz(start)
  }
  paste(start_time, "-", end_time, tz_)
}

fmt_time <- function(x) {
  x <- format(x, format = "%I:%M%p")
  x <- sub("^0", "", x)
  x <- sub("AM", "am", x)
  sub("PM", "pm", x)
}

#dates <- c("2022-03-04", "2022-03-18", "2022-04-01", "2022-04-15", "2022-04-29")
#' @importFrom lubridate month day
#' @importFrom dplyr arrange mutate group_by group_split
#' @importFrom purrr map
pretty_date_sequence <- function(dates){
  data.frame(Dates = dates) %>% 
    arrange(Dates) %>% 
    mutate(Month = month(Dates), Day = day(Dates)) %>% 
    group_by(Month) %>% 
    group_split() %>% 
    map(function(x){
      month_name <- month.name[unique(x$Month)]
      day_string <- paste(x$Day, collapse = ", ")
      paste(month_name, day_string)
    }) %>% 
    unlist() %>% 
    paste0(collapse = ", ")
}

#' @importFrom googlesheets4 read_sheet
get_registry <- function(url){
  list(
    cohort_metadata = read_sheet(url, sheet = "cohort_metadata", col_types = "c"),
    call_metadata = read_sheet(url, sheet = "call_metadata", col_types = "c")
  )
}

#' @importFrom lubridate as_date
usa_date_to_iso8601 <- function(x){
  as_date(as.POSIXct(x, format = "%m/%d/%Y"))
}

fmt_schedule_dates <- function(date_range){
  months_ <- month(date_range) %>% 
    as.character() %>% 
    map_chr(~ifelse(nchar(.x) == 1, paste0("0", .x), .x))
  days_ <- day(date_range) %>% 
    as.character() %>% 
    map_chr(~ifelse(nchar(.x) == 1, paste0("0", .x), .x))
  paste0(months_, "/", days_)
}

get_cohort_type <- function(cohort_registry, cohort_id) {
  cohort_registry %>% 
    filter(cohort_name == cohort_id) %>% 
    pull(cohort_type)
}

get_template_files <- function(call_registry, call_number, cohort_type_) {
  call_registry %>% 
    filter(call == call_number) %>% 
    filter(cohort_type == cohort_type_) %>% 
    as.character() %>% 
    keep(~nzchar(file_ext(.x)))
}

warn_if_any_not_rmd <- function(template_files) {
  not_rmd <- template_files %>% 
    file_ext() %>% 
    keep(nzchar) %>% 
    map_lgl(~!grepl("[R|r]md$", .x))
  
  if(any(not_rmd)){
    warning(paste(
      "The following file(s) are not Rmd files which may cause errors:",
      paste(template_files[not_rmd], collapse = ", ")
    ))
  }
}

stop_if_any_templates_not_installed <- function(template_files) {
  templates_installed <- (template_files %in% basename(kyber_file()))
  
  if(!all(templates_installed)){
    stop(paste(
      "The following template file(s) could not be found:",
      paste(template_files[!templates_installed], collapse = ", ")
    ))
  }
}
