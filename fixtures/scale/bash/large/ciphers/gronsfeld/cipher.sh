# Gronsfeld cipher: repeating key "31415" mixed into the byte stream.

GRONSFELD_KEY="31415"

gronsfeld_encrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#GRONSFELD_KEY} ))
    printf -v k '%d' "'${GRONSFELD_KEY:ki:1}"
    v=$(( (v + k) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

gronsfeld_decrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#GRONSFELD_KEY} ))
    printf -v k '%d' "'${GRONSFELD_KEY:ki:1}"
    v=$(( (v + 256 - k) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
