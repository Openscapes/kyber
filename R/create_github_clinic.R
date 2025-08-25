#' Create GitHub Clinic Files
#'
#' @param names A vector of names for the markdown files that should be created.
#' The `.md` extension will be added automatically.
#' @param path Path to the directory where `github-clinic` should be created.
#' 
#' @importFrom fs path dir_create file_copy
#' @export
#' @examples 
#' \dontrun{
#' 
#' create_github_clinic(names = c("julia", "erin"))
#' 
#' file.exists("github-clinic")
#' #> TRUE
#' 
#' list.files("github-clinic")
#' #> "erin.md"  "julia.md"
#' }
create_github_clinic <- function(names, path = getwd()) {
  if (any(duplicated(names))) {
    cli::cli_abort(
      "Each name must be unique, but {unique(names[duplicated(names)])} {?is/are} duplicated."
    )
  }
  
  names <- gsub("^\\s+|\\s+$", "", names)
  names <- gsub("\\s+", "-", names)
  
  clinic_template <- system.file("kyber-templates", 
                                 "github_clinic_md_text.md", package = "kyber")
  clinic_path <- fs::path(path, "github-clinic")
  fs::dir_create(clinic_path)
  file_names <- fs::dir_ls(clinic_path, glob = "*.md")

  for (i in names) {
    if (paste0(i, ".md") %in% basename(file_names)) {
      cli::cli_warn(
        "A file named {.file {i}.md} already exists. It has prepended with {.code _duplicate_}; please fix manually."
      )
      i <- paste0("_duplicate_", i)
    }
    fs::file_copy(clinic_template, fs::path(clinic_path, i, ext = "md"))
  }
  invisible(clinic_path)
}