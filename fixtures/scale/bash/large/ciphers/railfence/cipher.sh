# RailFence cipher: block transposition with period 6.

RAILFENCE_PERM=(0 2 4 1 3 5)
RAILFENCE_INV=(0 3 1 4 2 5)

railfence_encrypt() {
  local text="$1" out="" base j n=${#text} p=6
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${RAILFENCE_PERM[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}

railfence_decrypt() {
  local text="$1" out="" base j n=${#text} p=6
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${RAILFENCE_INV[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}
