# Benchmark runner for the railfence cipher.

source ./ciphers/railfence/cipher.sh
source ./ciphers/railfence/keys.sh

railfence_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(railfence_encrypt "$sample")
  done
  echo "${#out}"
}

railfence_bench_label() {
  echo "railfence x${1:-16}"
}
