# table subcommand: two-column key=value rendering.

source ./lib/align.sh
source ./lib/log.sh

table_sep() {
  printf '%s\n' "-------------------------------"
}

table_row() {
  local key="${1%%=*}" val="${1#*=}"
  printf '%-14s %s\n' "$key" "$val"
}

cmd_table() {
  local row
  table_sep
  for row in "$@"; do
    table_row "$row"
  done
  table_sep
}
