# Autokey cipher: repeating key "QUEEN" mixed into the byte stream.

AUTOKEY_KEY="QUEEN"

autokey_encrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#AUTOKEY_KEY} ))
    printf -v k '%d' "'${AUTOKEY_KEY:ki:1}"
    v=$(( (v + k) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

autokey_decrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#AUTOKEY_KEY} ))
    printf -v k '%d' "'${AUTOKEY_KEY:ki:1}"
    v=$(( (v + 256 - k) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
