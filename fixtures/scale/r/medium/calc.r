#!/usr/bin/env Rscript
# calc - floating point expression calculator with a function library.

source("core/config.r")
source("core/errors.r")
source("core/history.r")
source("core/memory.r")
source("core/format.r")
source("core/registry.r")
source("core/constants.r")
source("lexer/tokens.r")
source("lexer/scan.r")
source("parser/expr.r")
source("parser/term.r")
source("parser/factor.r")
source("eval.r")
source("funcs/index.r")
source("repl.r")

usage <- function() {
  cat("usage: calc [-e EXPR] [--repl]\n")
}

main <- function(argv = commandArgs(trailingOnly = TRUE)) {
  if (length(argv) >= 2 && argv[1] == "-e") {
    cat(fmt_result(eval_expr(argv[2])), "\n")
  } else if (length(argv) >= 1 && argv[1] == "--repl") {
    repl_loop()
  } else {
    usage()
  }
}

main()
