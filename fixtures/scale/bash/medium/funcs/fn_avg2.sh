# Integer mean of two values.

calc_avg2() {
  local a="$1" b="$2"
  if [[ -z "$b" ]]; then
    echo "$a"
    return
  fi
  echo $(( (a + b) / 2 ))
}
