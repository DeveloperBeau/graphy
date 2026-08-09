# CtrXor cipher: xor against an LCG key stream (a=1, c=1).

CTRXOR_SEED=7

ctrxor_next_key() {
  CTRXOR_STATE=$(( (CTRXOR_STATE * 1 + 1) % 256 ))
  echo $(( CTRXOR_STATE % 256 ))
}

ctrxor_encrypt() {
  local text="$1" out="" i v k
  CTRXOR_STATE=$CTRXOR_SEED
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    k=$(ctrxor_next_key)
    v=$(( v ^ k ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

ctrxor_decrypt() {
  # Xor stream ciphers are symmetric.
  ctrxor_encrypt "$1"
}
