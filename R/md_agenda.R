#' Options for creating an agenda in Markdown
#'
#' @importFrom rmarkdown md_document
#' @returns A `list` of options.
#' @export
md_agenda <- function() {
  list(type = "md", output_format = md_document())
}
