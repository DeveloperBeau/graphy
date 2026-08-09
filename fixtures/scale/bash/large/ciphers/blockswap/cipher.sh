# BlockSwap cipher: block transposition with period 8.

BLOCKSWAP_PERM=(4 5 6 7 0 1 2 3)
BLOCKSWAP_INV=(4 5 6 7 0 1 2 3)

blockswap_encrypt() {
  local text="$1" out="" base j n=${#text} p=8
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${BLOCKSWAP_PERM[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}

blockswap_decrypt() {
  local text="$1" out="" base j n=${#text} p=8
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${BLOCKSWAP_INV[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}
