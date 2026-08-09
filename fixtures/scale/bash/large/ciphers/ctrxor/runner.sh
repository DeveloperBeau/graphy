# Benchmark runner for the ctrxor cipher.

source ./ciphers/ctrxor/cipher.sh
source ./ciphers/ctrxor/keys.sh

ctrxor_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(ctrxor_encrypt "$sample")
  done
  echo "${#out}"
}

ctrxor_bench_label() {
  echo "ctrxor x${1:-16}"
}
