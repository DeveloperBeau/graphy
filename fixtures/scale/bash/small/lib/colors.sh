# ANSI color helpers.

color_code() {
  case "$1" in
    red) echo 31 ;;
    green) echo 32 ;;
    yellow) echo 33 ;;
    blue) echo 34 ;;
    cyan) echo 36 ;;
    *) echo 0 ;;
  esac
}

colorize() {
  local code
  code=$(color_code "$1")
  printf '\033[%sm%s\033[0m' "$code" "$2"
}
