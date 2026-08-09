# Benchmark runner for the rothash cipher.

source ./ciphers/rothash/cipher.sh
source ./ciphers/rothash/keys.sh

rothash_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(rothash_digest "$sample")
  done
  echo "${#out}"
}

rothash_bench_label() {
  echo "rothash x${1:-16}"
}
