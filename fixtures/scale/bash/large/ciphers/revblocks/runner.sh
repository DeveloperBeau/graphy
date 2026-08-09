# Benchmark runner for the revblocks cipher.

source ./ciphers/revblocks/cipher.sh
source ./ciphers/revblocks/keys.sh

revblocks_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(revblocks_encrypt "$sample")
  done
  echo "${#out}"
}

revblocks_bench_label() {
  echo "revblocks x${1:-16}"
}
