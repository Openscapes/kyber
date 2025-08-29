#' Get the paths to files installed with kyber
#'
#' This function allows you to quickly access files that are installed with
#' kyber.
#'
#' @param path The name of the file. If no argument is provided then
#' all of the example files will be listed.
#'
#' @return A vector of file paths
#' @export
#' @examples
#' kyber_file("_opening.Rmd")
#'
kyber_file <- function(path = NULL) {
  kyber_inst_dirs <- c(
    "agendas",
    "kyber-templates",
    "ms-word-themes",
    "certificate"
  )
  if (is.null(path)) {
    list.files(
      system.file(kyber_inst_dirs, package = "kyber"),
      full.names = TRUE
    )
  } else {
    system.file(kyber_inst_dirs, path, package = "kyber", mustWork = TRUE)
  }
}
