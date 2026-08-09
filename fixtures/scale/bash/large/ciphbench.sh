#!/usr/bin/env bash
# ciphbench - throughput and round-trip checks for toy ciphers.
set -euo pipefail

source ./core/log.sh
source ./core/config.sh
source ./core/args.sh
source ./core/timer.sh
source ./core/corpus.sh
source ./core/store.sh
source ./core/csv.sh
source ./core/progress.sh
source ./core/registry.sh
source ./core/format.sh
source ./core/report.sh
source ./core/summary.sh
source ./core/run.sh
source ./ciphers/index_shift.sh
source ./ciphers/index_vigenere.sh
source ./ciphers/index_stream.sh
source ./ciphers/index_transposition.sh
source ./ciphers/index_hash.sh

usage() {
  echo "usage: ciphbench <run|report|verify> [cipher...]"
}

main() {
  case "${1:-}" in
    run) shift; bench_all "$@" ;;
    report) report_summary ;;
    verify) shift; verify_all "$@" ;;
    *) usage ;;
  esac
}

main "$@"
