#!/usr/bin/env bash
# calc - integer expression calculator with a small function library.
set -euo pipefail

source ./core/log.sh
source ./core/config.sh
source ./core/errors.sh
source ./core/history.sh
source ./core/memory.sh
source ./core/format.sh
source ./core/registry.sh
source ./lexer/token.sh
source ./lexer/scan.sh
source ./parser/expr.sh
source ./parser/term.sh
source ./parser/factor.sh
source ./eval.sh
source ./funcs/index.sh
source ./repl.sh

usage() {
  echo "usage: calc [-e EXPR] [--repl]"
}

main() {
  case "${1:-}" in
    -e) eval_expr "$2" ;;
    --repl) repl_loop ;;
    *) usage ;;
  esac
}

main "$@"
