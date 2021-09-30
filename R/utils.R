check_gh_pat <- function(){
  if(nchar(Sys.getenv("GITHUB_PAT")) < 1) {
    stop("Please set your GITHUB_PAT.", call. = FALSE)
  }
}
