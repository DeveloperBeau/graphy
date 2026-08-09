# Benchmark runner for the djb2 cipher.

source ./ciphers/djb2/cipher.sh
source ./ciphers/djb2/keys.sh

djb2_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(djb2_digest "$sample")
  done
  echo "${#out}"
}

djb2_bench_label() {
  echo "djb2 x${1:-16}"
}
