# RotBlocks cipher: block transposition with period 6.

ROTBLOCKS_PERM=(2 3 4 5 0 1)
ROTBLOCKS_INV=(4 5 0 1 2 3)

rotblocks_encrypt() {
  local text="$1" out="" base j n=${#text} p=6
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${ROTBLOCKS_PERM[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}

rotblocks_decrypt() {
  local text="$1" out="" base j n=${#text} p=6
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${ROTBLOCKS_INV[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}
