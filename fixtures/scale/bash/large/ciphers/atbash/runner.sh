# Benchmark runner for the atbash cipher.

source ./ciphers/atbash/cipher.sh
source ./ciphers/atbash/keys.sh

atbash_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(atbash_encrypt "$sample")
  done
  echo "${#out}"
}

atbash_bench_label() {
  echo "atbash x${1:-16}"
}
