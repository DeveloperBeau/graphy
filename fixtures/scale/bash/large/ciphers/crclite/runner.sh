# Benchmark runner for the crclite cipher.

source ./ciphers/crclite/cipher.sh
source ./ciphers/crclite/keys.sh

crclite_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(crclite_digest "$sample")
  done
  echo "${#out}"
}

crclite_bench_label() {
  echo "crclite x${1:-16}"
}
