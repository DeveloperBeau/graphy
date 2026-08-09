# ZigZag cipher: block transposition with period 2.

ZIGZAG_PERM=(1 0)
ZIGZAG_INV=(1 0)

zigzag_encrypt() {
  local text="$1" out="" base j n=${#text} p=2
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${ZIGZAG_PERM[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}

zigzag_decrypt() {
  local text="$1" out="" base j n=${#text} p=2
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${ZIGZAG_INV[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}
