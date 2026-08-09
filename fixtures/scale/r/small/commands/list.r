# list subcommand: bulleted items from arguments.

source("lib/style.r")
source("lib/log.r")

list_item <- function(item) {
  sprintf("  * %s", item)
}

cmd_list <- function(items) {
  log_info("list with", length(items), "items")
  for (item in items) {
    cat(list_item(item), "\n")
  }
}
