# Human-readable units.

fmt_bytes() {
  local n="$1"
  if (( n >= 1048576 )); then
    echo "$(( n / 1048576 ))MiB"
  elif (( n >= 1024 )); then
    echo "$(( n / 1024 ))KiB"
  else
    echo "${n}B"
  fi
}

fmt_micros() {
  local us="$1"
  if (( us >= 1000000 )); then
    echo "$(( us / 1000000 ))s"
  else
    echo "${us}us"
  fi
}
