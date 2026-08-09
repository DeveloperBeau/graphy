# Runkey cipher: repeating key "THEQUICKBROWNFOX" mixed into the byte stream.

RUNKEY_KEY="THEQUICKBROWNFOX"

runkey_encrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#RUNKEY_KEY} ))
    printf -v k '%d' "'${RUNKEY_KEY:ki:1}"
    v=$(( (v + k) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

runkey_decrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#RUNKEY_KEY} ))
    printf -v k '%d' "'${RUNKEY_KEY:ki:1}"
    v=$(( (v + 256 - k) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
