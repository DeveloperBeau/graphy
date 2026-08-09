# Benchmark runner for the caesar cipher.

source ./ciphers/caesar/cipher.sh
source ./ciphers/caesar/keys.sh

caesar_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(caesar_encrypt "$sample")
  done
  echo "${#out}"
}

caesar_bench_label() {
  echo "caesar x${1:-16}"
}
