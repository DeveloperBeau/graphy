#!/usr/bin/env bash
# textprint - render styled text blocks in the terminal.
set -euo pipefail

source ./config.sh
source ./version.sh
source ./commands/banner.sh
source ./commands/list.sh
source ./commands/table.sh

usage() {
  echo "usage: textprint <banner|list|table> [args...]"
  echo "  textprint $(textprint_version)"
}

main() {
  local cmd="${1:-help}"
  shift || true
  case "$cmd" in
    banner) cmd_banner "$@" ;;
    list)   cmd_list "$@" ;;
    table)  cmd_table "$@" ;;
    *)      usage ;;
  esac
}

main "$@"
