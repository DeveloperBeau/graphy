# Benchmark runner for the rot13 cipher.

source ./ciphers/rot13/cipher.sh
source ./ciphers/rot13/keys.sh

rot13_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(rot13_encrypt "$sample")
  done
  echo "${#out}"
}

rot13_bench_label() {
  echo "rot13 x${1:-16}"
}
