# Benchmark runner for the vigenere cipher.

source ./ciphers/vigenere/cipher.sh
source ./ciphers/vigenere/keys.sh

vigenere_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(vigenere_encrypt "$sample")
  done
  echo "${#out}"
}

vigenere_bench_label() {
  echo "vigenere x${1:-16}"
}
