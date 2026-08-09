# Benchmark runner for the shift5 cipher.

source ./ciphers/shift5/cipher.sh
source ./ciphers/shift5/keys.sh

shift5_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(shift5_encrypt "$sample")
  done
  echo "${#out}"
}

shift5_bench_label() {
  echo "shift5 x${1:-16}"
}
