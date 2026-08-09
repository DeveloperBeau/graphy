# Deterministic sample text for benchmark runs.

CORPUS_BASE="the quick brown fox jumps over the lazy dog 0123456789"

corpus_repeat() {
  local n="$1" out=""
  while (( ${#out} < n )); do
    out+="$CORPUS_BASE "
  done
  echo "${out:0:n}"
}

corpus_sample() {
  corpus_repeat "${1:-512}"
}
