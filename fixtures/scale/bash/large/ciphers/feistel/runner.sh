# Benchmark runner for the feistel cipher.

source ./ciphers/feistel/cipher.sh
source ./ciphers/feistel/keys.sh

feistel_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(feistel_encrypt "$sample")
  done
  echo "${#out}"
}

feistel_bench_label() {
  echo "feistel x${1:-16}"
}
