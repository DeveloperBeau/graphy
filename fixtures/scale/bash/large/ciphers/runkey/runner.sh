# Benchmark runner for the runkey cipher.

source ./ciphers/runkey/cipher.sh
source ./ciphers/runkey/keys.sh

runkey_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(runkey_encrypt "$sample")
  done
  echo "${#out}"
}

runkey_bench_label() {
  echo "runkey x${1:-16}"
}
