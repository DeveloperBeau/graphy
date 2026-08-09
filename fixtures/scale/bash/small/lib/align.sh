# Horizontal alignment within a fixed width.

pad_left() {
  printf '%*s' "$2" "$1"
}

pad_right() {
  printf '%-*s' "$2" "$1"
}

center_text() {
  local text="$1" width="$2" lead
  lead=$(( (width - ${#text}) / 2 + ${#text} ))
  pad_left "$text" "$lead"
}
