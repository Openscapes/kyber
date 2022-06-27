#' Add .gitignore to a directory.
#' 
#' @param path The path to the directory where the git ignore file will be 
#' created.
#' 
#' @export
add_gitignore <- function(path = getwd()){
  file_name <- "gitignore.md"
  kyber_file <- system.file("kyber-templates", file_name, package = "kyber")
  destination_path <- fs::path(path, ".gitignore")
  
  if(file.exists(destination_path)){
    warning(destination_path, " already exists.")
    return(invisible(FALSE))
  }
  
  file_copy(kyber_file, destination_path)
}

#' Add a Code of Conduct to a directory.
#' 
#' @param path The path to the directory where the code of conduct file will be 
#' created.
#' 
#' @importFrom fs file_copy path
#' @export
add_code_of_conduct <- function(path = getwd()){
  file_name <- "code_of_conduct.md"
  kyber_file <- system.file("kyber-templates", file_name, package = "kyber")
  destination_path <- fs::path(path, file_name)
  
  if(file.exists(destination_path)){
    warning(destination_path, " already exists.")
    return(invisible(FALSE))
  }
  
  file_copy(kyber_file, destination_path)
}