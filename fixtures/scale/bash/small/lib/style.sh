# Text emphasis via ANSI escape codes.

style_bold() {
  printf '\033[1m%s\033[0m' "$1"
}

style_underline() {
  printf '\033[4m%s\033[0m' "$1"
}

apply_style() {
  case "$1" in
    bold) style_bold "$2" ;;
    underline) style_underline "$2" ;;
    *) printf '%s' "$2" ;;
  esac
}
