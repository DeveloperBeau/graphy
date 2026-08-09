# Smallest prime greater than n.

calc_nextprime() {
  local n="$1" c
  c=$(( n + 1 ))
  while [[ "$(calc_isprime "$c")" != 1 ]]; do
    c=$(( c + 1 ))
  done
  echo "$c"
}
