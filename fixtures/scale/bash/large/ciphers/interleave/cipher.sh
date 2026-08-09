# Interleave cipher: block transposition with period 8.

INTERLEAVE_PERM=(0 2 4 6 1 3 5 7)
INTERLEAVE_INV=(0 4 1 5 2 6 3 7)

interleave_encrypt() {
  local text="$1" out="" base j n=${#text} p=8
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${INTERLEAVE_PERM[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}

interleave_decrypt() {
  local text="$1" out="" base j n=${#text} p=8
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${INTERLEAVE_INV[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}
