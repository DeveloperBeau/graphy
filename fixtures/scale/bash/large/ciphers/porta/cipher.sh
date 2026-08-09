# Porta cipher: repeating key "GLACIER" mixed into the byte stream.

PORTA_KEY="GLACIER"

porta_encrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#PORTA_KEY} ))
    printf -v k '%d' "'${PORTA_KEY:ki:1}"
    v=$(( (k + 256 - v) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

porta_decrypt() {
  # Subtraction against the key stream is its own inverse.
  porta_encrypt "$1"
}
