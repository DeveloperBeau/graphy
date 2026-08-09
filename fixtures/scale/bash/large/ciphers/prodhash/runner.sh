# Benchmark runner for the prodhash cipher.

source ./ciphers/prodhash/cipher.sh
source ./ciphers/prodhash/keys.sh

prodhash_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(prodhash_digest "$sample")
  done
  echo "${#out}"
}

prodhash_bench_label() {
  echo "prodhash x${1:-16}"
}
