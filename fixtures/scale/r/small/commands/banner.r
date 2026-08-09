# banner subcommand: one centered, framed headline.

source("lib/colors.r")
source("lib/align.r")
source("lib/border.r")
source("lib/log.r")

cmd_banner <- function(text) {
  width <- config_get("width")
  log_info("banner width =", width)
  centered <- center_text(text, width)
  cat(border_wrap(centered, width), sep = "\n")
}

banner_preview <- function(text) {
  colorize("cyan", center_text(text, 40))
}
