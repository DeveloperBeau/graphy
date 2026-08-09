# Single-slot memory register (M+, MR, MC).

CALC_MEM=0

mem_store() {
  CALC_MEM="$1"
}

mem_recall() {
  echo "$CALC_MEM"
}

mem_clear() {
  CALC_MEM=0
}
