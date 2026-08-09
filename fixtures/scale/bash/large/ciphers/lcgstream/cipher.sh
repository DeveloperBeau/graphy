# LcgStream cipher: xor against an LCG key stream (a=1229, c=17).

LCGSTREAM_SEED=42

lcgstream_next_key() {
  LCGSTREAM_STATE=$(( (LCGSTREAM_STATE * 1229 + 17) % 32749 ))
  echo $(( LCGSTREAM_STATE % 256 ))
}

lcgstream_encrypt() {
  local text="$1" out="" i v k
  LCGSTREAM_STATE=$LCGSTREAM_SEED
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    k=$(lcgstream_next_key)
    v=$(( v ^ k ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

lcgstream_decrypt() {
  # Xor stream ciphers are symmetric.
  lcgstream_encrypt "$1"
}
