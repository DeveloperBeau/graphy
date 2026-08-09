# Benchmark runner for the porta cipher.

source ./ciphers/porta/cipher.sh
source ./ciphers/porta/keys.sh

porta_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(porta_encrypt "$sample")
  done
  echo "${#out}"
}

porta_bench_label() {
  echo "porta x${1:-16}"
}
