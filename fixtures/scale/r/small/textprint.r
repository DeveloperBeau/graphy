#!/usr/bin/env Rscript
# textprint - render styled text blocks in the terminal.

source("config.r")
source("version.r")
source("commands/banner.r")
source("commands/list.r")
source("commands/table.r")

usage <- function() {
  cat("usage: textprint <banner|list|table> [args...]\n")
  cat(sprintf("  textprint %s\n", textprint_version()))
}

main <- function(argv = commandArgs(trailingOnly = TRUE)) {
  command <- if (length(argv) > 0) argv[1] else "help"
  rest <- if (length(argv) > 1) argv[-1] else character(0)
  switch(command,
    banner = cmd_banner(paste(rest, collapse = " ")),
    list = cmd_list(rest),
    table = cmd_table(rest),
    usage()
  )
}

main()
