# Rc4Lite cipher: xor against an LCG key stream (a=181, c=359).

RC4LITE_SEED=17

rc4lite_next_key() {
  RC4LITE_STATE=$(( (RC4LITE_STATE * 181 + 359) % 65521 ))
  echo $(( RC4LITE_STATE % 256 ))
}

rc4lite_encrypt() {
  local text="$1" out="" i v k
  RC4LITE_STATE=$RC4LITE_SEED
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    k=$(rc4lite_next_key)
    v=$(( v ^ k ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

rc4lite_decrypt() {
  # Xor stream ciphers are symmetric.
  rc4lite_encrypt "$1"
}
