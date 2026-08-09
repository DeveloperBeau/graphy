# banner subcommand: one centered, framed headline.

source ./lib/colors.sh
source ./lib/align.sh
source ./lib/border.sh
source ./lib/log.sh

cmd_banner() {
  local text="${1:-hello}" width
  width=$(config_get width)
  log_info "banner width=$width"
  center_text "$text" "$width" | border_wrap "$width"
}

banner_preview() {
  colorize cyan "$(center_text "$1" 40)"
}
