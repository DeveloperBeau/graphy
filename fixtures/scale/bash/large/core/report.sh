# Post-run report over the stored results.

report_line() {
  local row="$1"
  printf '  %s\n' "${row//\",\"/  }"
}

report_summary() {
  local path row
  path=$(store_path)
  [[ -f "$path" ]] || { log_warn "no results at $path"; return 1; }
  echo "results from $path:"
  while IFS= read -r row; do
    report_line "$row"
  done < "$path"
}
