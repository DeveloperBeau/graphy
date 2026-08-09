# Beaufort cipher: repeating key "FORTRESS" mixed into the byte stream.

BEAUFORT_KEY="FORTRESS"

beaufort_encrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#BEAUFORT_KEY} ))
    printf -v k '%d' "'${BEAUFORT_KEY:ki:1}"
    v=$(( (k + 256 - v) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

beaufort_decrypt() {
  # Subtraction against the key stream is its own inverse.
  beaufort_encrypt "$1"
}
