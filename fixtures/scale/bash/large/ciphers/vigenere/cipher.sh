# Vigenere cipher: repeating key "LEMON" mixed into the byte stream.

VIGENERE_KEY="LEMON"

vigenere_encrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#VIGENERE_KEY} ))
    printf -v k '%d' "'${VIGENERE_KEY:ki:1}"
    v=$(( (v + k) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

vigenere_decrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#VIGENERE_KEY} ))
    printf -v k '%d' "'${VIGENERE_KEY:ki:1}"
    v=$(( (v + 256 - k) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
