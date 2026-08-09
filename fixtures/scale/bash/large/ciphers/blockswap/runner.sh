# Benchmark runner for the blockswap cipher.

source ./ciphers/blockswap/cipher.sh
source ./ciphers/blockswap/keys.sh

blockswap_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(blockswap_encrypt "$sample")
  done
  echo "${#out}"
}

blockswap_bench_label() {
  echo "blockswap x${1:-16}"
}
