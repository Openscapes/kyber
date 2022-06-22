# # Readme Formatting
# # 
# # @description 
# # Functions to help format yaml data nicely in Readme templates.
# # 
# # @name formatting
# # @param link A url for an online wiki.
# # @param schedule A list of data frames that will be combined, row-wise.
# # @aliases NULL
# NULL
# 
# # @rdname formatting
# # @export
# ky_fmt_wiki_link <- function(link) {
#   if(!is.null(link)){
#     paste0("This cohort GitHub organzation also has a [wiki](", 
#            link, 
#            ") with GitHub links and resources that you can reference and add to.")
#     }
# }
# 
# # @rdname formatting
# #' @importFrom knitr kable
# # @export
# ky_fmt_schedule <- function(schedule) {
#   kable(do.call(rbind, as.list(schedule)))
# }
# 
