# Scytale cipher: block transposition with period 6.

SCYTALE_PERM=(0 3 1 4 2 5)
SCYTALE_INV=(0 2 4 1 3 5)

scytale_encrypt() {
  local text="$1" out="" base j n=${#text} p=6
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${SCYTALE_PERM[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}

scytale_decrypt() {
  local text="$1" out="" base j n=${#text} p=6
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${SCYTALE_INV[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}
