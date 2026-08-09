# Benchmark runner for the autokey cipher.

source ./ciphers/autokey/cipher.sh
source ./ciphers/autokey/keys.sh

autokey_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(autokey_encrypt "$sample")
  done
  echo "${#out}"
}

autokey_bench_label() {
  echo "autokey x${1:-16}"
}
