# RevBlocks cipher: block transposition with period 4.

REVBLOCKS_PERM=(3 2 1 0)
REVBLOCKS_INV=(3 2 1 0)

revblocks_encrypt() {
  local text="$1" out="" base j n=${#text} p=4
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${REVBLOCKS_PERM[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}

revblocks_decrypt() {
  local text="$1" out="" base j n=${#text} p=4
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${REVBLOCKS_INV[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}
