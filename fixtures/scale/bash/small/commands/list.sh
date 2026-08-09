# list subcommand: bulleted items from arguments.

source ./lib/style.sh
source ./lib/log.sh

list_item() {
  printf '  * %s\n' "$1"
}

cmd_list() {
  local item
  log_info "list with $# items"
  for item in "$@"; do
    list_item "$item"
  done
}
