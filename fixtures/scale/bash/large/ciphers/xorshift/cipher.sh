# XorShift cipher: xor against a 16-bit xorshift key stream.

XORSHIFT_SEED=911

xorshift_next_key() {
  XORSHIFT_STATE=$(( (XORSHIFT_STATE ^ (XORSHIFT_STATE << 3)) & 65535 ))
  XORSHIFT_STATE=$(( (XORSHIFT_STATE ^ (XORSHIFT_STATE >> 5)) & 65535 ))
  echo $(( XORSHIFT_STATE % 256 ))
}

xorshift_encrypt() {
  local text="$1" out="" i v k
  XORSHIFT_STATE=$XORSHIFT_SEED
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    k=$(xorshift_next_key)
    v=$(( v ^ k ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

xorshift_decrypt() {
  # Xor stream ciphers are symmetric.
  xorshift_encrypt "$1"
}
