# Benchmark runner for the sum32 cipher.

source ./ciphers/sum32/cipher.sh
source ./ciphers/sum32/keys.sh

sum32_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(sum32_digest "$sample")
  done
  echo "${#out}"
}

sum32_bench_label() {
  echo "sum32 x${1:-16}"
}
