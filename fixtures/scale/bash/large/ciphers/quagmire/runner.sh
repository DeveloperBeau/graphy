# Benchmark runner for the quagmire cipher.

source ./ciphers/quagmire/cipher.sh
source ./ciphers/quagmire/keys.sh

quagmire_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(quagmire_encrypt "$sample")
  done
  echo "${#out}"
}

quagmire_bench_label() {
  echo "quagmire x${1:-16}"
}
