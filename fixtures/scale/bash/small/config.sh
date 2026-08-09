# Runtime defaults, overridable via TEXTPRINT_* environment variables.

TP_WIDTH="${TEXTPRINT_WIDTH:-72}"
TP_STYLE="${TEXTPRINT_STYLE:-plain}"
TP_COLOR="${TEXTPRINT_COLOR:-auto}"

config_get() {
  case "$1" in
    width) echo "$TP_WIDTH" ;;
    style) echo "$TP_STYLE" ;;
    color) echo "$TP_COLOR" ;;
    *) return 1 ;;
  esac
}

config_use_color() {
  [[ "$TP_COLOR" == "always" ]] || { [[ "$TP_COLOR" == "auto" ]] && [[ -t 1 ]]; }
}
