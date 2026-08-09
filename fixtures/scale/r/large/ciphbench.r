#!/usr/bin/env Rscript
# ciphbench - throughput and round-trip checks for toy ciphers.

source("core/log.r")
source("core/config.r")
source("core/args.r")
source("core/timer.r")
source("core/corpus.r")
source("core/store.r")
source("core/csv.r")
source("core/progress.r")
source("core/registry.r")
source("core/format.r")
source("core/report.r")
source("core/summary.r")
source("core/run.r")
source("ciphers/index_shift.r")
source("ciphers/index_vigenere.r")
source("ciphers/index_stream.r")
source("ciphers/index_transposition.r")
source("ciphers/index_hash.r")

usage <- function() {
  cat("usage: ciphbench <run|report|verify>\n")
}

main <- function(argv = commandArgs(trailingOnly = TRUE)) {
  command <- if (length(argv) > 0) argv[1] else "help"
  switch(command,
    run = bench_all(),
    report = report_summary(),
    verify = verify_all(),
    usage()
  )
}

main()
