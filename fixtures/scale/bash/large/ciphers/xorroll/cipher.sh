# XorRoll cipher: xor against an LCG key stream (a=75, c=74).

XORROLL_SEED=193

xorroll_next_key() {
  XORROLL_STATE=$(( (XORROLL_STATE * 75 + 74) % 65537 ))
  echo $(( XORROLL_STATE % 256 ))
}

xorroll_encrypt() {
  local text="$1" out="" i v k
  XORROLL_STATE=$XORROLL_SEED
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    k=$(xorroll_next_key)
    v=$(( v ^ k ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

xorroll_decrypt() {
  # Xor stream ciphers are symmetric.
  xorroll_encrypt "$1"
}
