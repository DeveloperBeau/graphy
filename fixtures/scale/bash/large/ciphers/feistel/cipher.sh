# Feistel cipher: xor against an LCG key stream (a=37, c=11).

FEISTEL_SEED=101

feistel_next_key() {
  FEISTEL_STATE=$(( (FEISTEL_STATE * 37 + 11) % 256 ))
  echo $(( FEISTEL_STATE % 256 ))
}

feistel_encrypt() {
  local text="$1" out="" i v k
  FEISTEL_STATE=$FEISTEL_SEED
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    k=$(feistel_next_key)
    v=$(( v ^ k ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

feistel_decrypt() {
  # Xor stream ciphers are symmetric.
  feistel_encrypt "$1"
}
