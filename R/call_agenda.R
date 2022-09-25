#' Create a Call Agenda
#' 
#' @param registry_url The URL to the cohort registry.
#' @param cohort_id The ID of the cohort.
#' @param call_number The call number of the agenda.
#' @param cohort_sheet The sheet in the registry with cohort information.
#' @param call_sheet The sheet in the registry with information about 
#' individual calls.
#' @param website A website for the cohort.
#' @param output_format The output format of the agenda.
#' @param output_file The name of the output file with no file extension.
#' @importFrom googlesheets4 read_sheet
#' @importFrom tools file_ext
#' @importFrom purrr keep map_lgl map map_chr map_dfr map_dbl discard
#' @importFrom dplyr filter pull
#' @importFrom parsermd parse_rmd as_tibble as_document
#' @importFrom rmarkdown render yaml_front_matter
#' @export
call_agenda <- function(registry_url, cohort_id, call_number,
                        cohort_sheet = "cohort_metadata", 
                        call_sheet = "call_metadata",
                        website = paste0("https://openscapes.github.io/", cohort_id), 
                        output_format = md_agenda(), output_file = "agenda.md"){
  
  cohort_registry <- read_sheet(registry_url, cohort_sheet, col_types = "c")
  call_registry <- read_sheet(registry_url, call_sheet, col_types = "c")
  temp_dir <- tempdir()
  params_registry <- list(website = website, cohort_name = cohort_id, 
                          call = call_number)
  cohort_name <- date_start <- type <- NULL
  
  template_files <- call_registry %>% 
    filter(call == call_number) %>% 
    as.character() %>% 
    keep(~nzchar(file_ext(.x)))
  
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
  
  templates_installed <- (template_files %in% basename(kyber_file()))
  
  if(!all(templates_installed)){
    stop(paste(
      "The following template file(s) could not be found:",
      paste(template_files[!templates_installed], collapse = ", ")
    ))
  }
  
  template_files <- template_files %>% 
    map_chr(kyber_file)
  
  params_registry$date <- cohort_registry %>% 
    filter(cohort_name == cohort_id) %>% 
    pull(date_start) %>% 
    usa_date_to_iso8601() %>% 
    as.character()
  
  params_registry$call_start_time <- cohort_registry %>% 
    filter(cohort_name == cohort_id) %>% 
    pull("time_start")
  
  tz <- tz(params_registry$call_start_time)
  
  params_registry$google_drive_folder <- cohort_registry %>% 
    filter(cohort_name == cohort_id) %>% 
    pull("google_drive_folder")
  
  params_registry$github_repo <- cohort_registry %>% 
    filter(cohort_name == cohort_id) %>% 
    pull("github_repo")

  params_registry$cohort_website <- cohort_registry %>% 
    filter(cohort_name == cohort_id) %>% 
    pull("cohort_website")
    
  params_registry$title <- call_registry %>% 
    filter(call == call_number) %>% 
    pull("title")
  
  template_params <- template_files %>% 
    map(yaml_front_matter) %>% 
    map(~.x$params)
  
  template_durations <- template_params %>% 
    map(~.x$duration) %>% 
    map_dbl(~ifelse(is.null(.x), NA, .x))
  
  params_registry$total_duration <- sum(template_durations, na.rm = TRUE)
  
  start_times <- durations_to_start_times(template_durations, 
                                          params_registry$call_start_time) %>% 
    map_chr(fmt_time) %>% 
    paste(tz)
  
  files <- template_params %>% 
    map(~.x$files) %>% 
    keep(Negate(is.null)) %>% 
    unlist() %>% 
    unique()
  
  if(length(files) > 0) {
    file.copy(
      system.file("agendas", files, package = "kyber"),
      dirname(output_file)
    )
  }
  
  param_names <- template_params %>% map(names) %>% 
    map(~discard(.x, ..1 %in% "files"))
  
  output_md_paths <- rep("", length(template_files))
  for(i in seq_along(template_files)){
    params_registry$start_time <- ifelse(i < 2, start_times[i], start_times[i - 1])
    params_registry$duration <- template_durations[i]
    
    output_md_paths[i] <- render(template_files[i], 
                                 output_format = output_format$output_format, 
                                 output_dir = temp_dir, 
                                 params = params_registry[param_names[[i]]])
  }
  
  new_output_md_paths <- gsub("\\.md$", ".Rmd", output_md_paths)
  old_output_md_paths <- output_md_paths
  test_rename <- rep(FALSE, length(output_md_paths))
  for (i in seq_along(output_md_paths)) {
    test_rename[i] <- file.rename(output_md_paths[i], new_output_md_paths[i])
  }
  output_md_paths <- new_output_md_paths
  
  result <- FALSE
  if(output_format$type == "md"){
    result <- output_file
    output_md_paths %>% 
      map(parse_rmd) %>% 
      map_dfr(as_tibble) %>% 
      filter(type != "rmd_yaml_list") %>% 
      as_document() %>% 
      writeLines(result)
  } else {
    stop("Agenda output format not supported.")
  }
  
  invisible(result)
}

durations_to_start_times <- function(durations, start) {
  start_time <- parse_date_time(start, orders = "%I:%M%p")
  durations[is.na(durations)] <- 0
  #durations[durations == max(durations)] <- 0
  start_time + minutes(cumsum(durations))
}

