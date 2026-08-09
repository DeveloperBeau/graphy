# Benchmark runner for the cbcxor cipher.

source ./ciphers/cbcxor/cipher.sh
source ./ciphers/cbcxor/keys.sh

cbcxor_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(cbcxor_encrypt "$sample")
  done
  echo "${#out}"
}

cbcxor_bench_label() {
  echo "cbcxor x${1:-16}"
}
