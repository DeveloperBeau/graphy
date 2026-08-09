# Stride cipher: block transposition with period 9.

STRIDE_PERM=(0 3 6 1 4 7 2 5 8)
STRIDE_INV=(0 3 6 1 4 7 2 5 8)

stride_encrypt() {
  local text="$1" out="" base j n=${#text} p=9
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${STRIDE_PERM[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}

stride_decrypt() {
  local text="$1" out="" base j n=${#text} p=9
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${STRIDE_INV[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}
