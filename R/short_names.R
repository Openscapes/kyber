#' Make unique combinations of first and last names
#' 
#' @param first A vector of first names.
#' @param last A vector of last names.
#' @export
#' @examples 
#' \dontrun{
#' 
#' first <- c("a", "b", "c")
#' last <- c("x1", "y2", "z3")
#' short_names(first, last)
#' #> "a" "b" "c"
#' 
#' first <- c("a", "a", "c")
#' last <- c("x1", "y2", "z3")
#' short_names(first, last)
#' #> "a_x" "a_y" "c"
#' 
#' first <- c("a", "a", "c")
#' last <- c("x144", "x255", "z3")
#' short_names(first, last)
#' #> "a_x144" "a_x255" "c"
#' 
#' first <- c("a", "a", "c", "d", "d")
#' last <- c("x144", "x255", "z3", "r4", "t5")
#' short_names(first, last)
#' #> "a_x144" "a_x255" "c"      "d_r"    "d_t"
#' 
#' first <- c("a", "a", "c")
#' last <- c("x1", "x1", "z3")
#' short_names(first, last)
#' #> "a_x1" "c"
#' #> Warning message:
#' #> In ky_short_names(first, last) :
#' #> First and Last pairs are not unique. Returning only unique combinations.
#' }
short_names <- function(first, last) {
  stopifnot(length(first) == length(last))
  
  first <- tolower(first)
  last <- tolower(last)
  
  if(length(unique(first)) == length(first)) {
    return(first)
  } else {
    repeats <- names(table(first))[table(first) > 1]
    result <- first
    for (i in seq_along(first)) {
      if(first[i] %in% repeats){
        result[i] <- paste0(first[i], "_", substring(last[i], 1, 1))  
      }
    }
  }
  
  if(length(unique(result)) == length(result)) {
    return(result)
  } else {
    repeats <- names(table(result))[table(result) > 1]
    for (i in seq_along(first)) {
      if(result[i] %in% repeats){
        result[i] <- paste0(first[i], "_", last[i])  
      }
    }
  }
  
  if(length(unique(result)) != length(result)){
    warning("First and Last pairs are not unique. Returning only unique combinations.",
            " The following short names are duplicates: ", result[duplicated(result)])
    unique(result)
  } else {
    result  
  }
}