#' Create a Team on GitHub for an Organization
#' 
#' @param name The name of the team.
#' @param maintainers One or more GitHub usernames that will be the team maintainers.
#' @param org The GitHub organization that will own the team.
#' @param visible Should the team be visible to every member of the organization?
#' 
#' @export
#' @examples
#' \dontrun{
#'
#' # One maintainer
#' kyber::create_team("2021-ilm-rotj-team", maintainers = "jules32")
#' 
#' # Multiple maintainers
#' kyber::create_team("2021-ilm-rotj-team", maintainers = c("jules32", "seankross"))
#' }
create_team <- function(name, maintainers, org = "openscapes", visible = TRUE) {
  check_gh_pat()
  
  # The way these parameter options are named makes no sense.
  # See: https://docs.github.com/en/rest/reference/teams#create-a-team
  if(visible){
    privacy <- "closed"
  } else {
    privacy <- "secret"
  }
  
  response <- gh("POST /orgs/{org}/teams", org = org, name = name,
                 maintainers = as.list(maintainers), privacy = privacy)
  invisible(response)
}