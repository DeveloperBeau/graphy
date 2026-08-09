# Columnar cipher: block transposition with period 4.

COLUMNAR_PERM=(3 1 0 2)
COLUMNAR_INV=(2 1 3 0)

columnar_encrypt() {
  local text="$1" out="" base j n=${#text} p=4
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${COLUMNAR_PERM[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}

columnar_decrypt() {
  local text="$1" out="" base j n=${#text} p=4
  for (( base = 0; base + p <= n; base += p )); do
    for (( j = 0; j < p; j++ )); do
      out+="${text:$(( base + ${COLUMNAR_INV[j]} )):1}"
    done
  done
  out+="${text:base}"
  printf '%s' "$out"
}
