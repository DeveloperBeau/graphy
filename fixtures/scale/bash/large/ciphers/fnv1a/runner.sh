# Benchmark runner for the fnv1a cipher.

source ./ciphers/fnv1a/cipher.sh
source ./ciphers/fnv1a/keys.sh

fnv1a_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(fnv1a_digest "$sample")
  done
  echo "${#out}"
}

fnv1a_bench_label() {
  echo "fnv1a x${1:-16}"
}
