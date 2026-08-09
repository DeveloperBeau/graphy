# Benchmark runner for the beaufort cipher.

source ./ciphers/beaufort/cipher.sh
source ./ciphers/beaufort/keys.sh

beaufort_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(beaufort_encrypt "$sample")
  done
  echo "${#out}"
}

beaufort_bench_label() {
  echo "beaufort x${1:-16}"
}
