# Benchmark runner for the sdbm cipher.

source ./ciphers/sdbm/cipher.sh
source ./ciphers/sdbm/keys.sh

sdbm_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(sdbm_digest "$sample")
  done
  echo "${#out}"
}

sdbm_bench_label() {
  echo "sdbm x${1:-16}"
}
