# CbcXor cipher: xor chained against the previous cipher byte.

CBCXOR_IV=113

cbcxor_next_key() {
  echo "$CBCXOR_PREV"
}

cbcxor_encrypt() {
  local text="$1" out="" i v k
  CBCXOR_PREV=$CBCXOR_IV
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    k=$(cbcxor_next_key)
    v=$(( v ^ k ))
    CBCXOR_PREV=$v
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

cbcxor_decrypt() {
  local text="$1" out="" i v k p
  p=$CBCXOR_IV
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    k=$v
    v=$(( v ^ p ))
    p=$k
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
