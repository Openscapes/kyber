check_gh_pat <- function(){
  if(nchar(Sys.getenv("GITHUB_PAT")) < 1) {
    stop("Please set your GITHUB_PAT.", call. = FALSE)
  }
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

#' @importFrom lubridate parse_date_time minutes
fmt_duration <- function(start, duration) {
  start_time <- parse_date_time(start, orders = "%I:%M%p")
  end_time <- start_time + minutes(duration)
  start_time <- fmt_time(start_time)
  end_time <- fmt_time(end_time)
  paste(start_time, "-", end_time, tz(start))
}

fmt_time <- function(x) {
  x <- format(x, format = "%I:%M%p")
  x <- sub("^0", "", x)
  x <- sub("AM", "am", x)
  sub("PM", "pm", x)
}

