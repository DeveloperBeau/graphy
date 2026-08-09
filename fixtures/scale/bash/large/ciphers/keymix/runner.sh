# Benchmark runner for the keymix cipher.

source ./ciphers/keymix/cipher.sh
source ./ciphers/keymix/keys.sh

keymix_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(keymix_encrypt "$sample")
  done
  echo "${#out}"
}

keymix_bench_label() {
  echo "keymix x${1:-16}"
}
