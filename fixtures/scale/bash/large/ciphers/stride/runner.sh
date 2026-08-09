# Benchmark runner for the stride cipher.

source ./ciphers/stride/cipher.sh
source ./ciphers/stride/keys.sh

stride_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(stride_encrypt "$sample")
  done
  echo "${#out}"
}

stride_bench_label() {
  echo "stride x${1:-16}"
}
