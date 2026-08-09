# Microsecond wall-clock timing.

timer_now() {
  local us=${EPOCHREALTIME/./}
  echo "$us"
}

timer_elapsed() {
  local start="$1" end
  end=$(timer_now)
  echo $(( end - start ))
}
