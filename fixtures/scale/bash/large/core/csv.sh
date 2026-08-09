# Minimal CSV encoding for the results file.

csv_escape() {
  local field="$1"
  printf '"%s"' "${field//\"/\"\"}"
}

csv_row() {
  local out="" field
  for field in "$@"; do
    out+=",$(csv_escape "$field")"
  done
  echo "${out#,}"
}

csv_header() {
  csv_row cipher rounds bytes micros
}
