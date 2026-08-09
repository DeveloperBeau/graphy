# Interactive read-eval-print loop.

repl_prompt() {
  printf 'calc> '
}

repl_loop() {
  local line result
  while repl_prompt && IFS= read -r line; do
    [[ "$line" == "quit" ]] && break
    result=$(eval_expr "$line") || continue
    history_add "$line" "$result"
    fmt_result "$result"
  done
}
