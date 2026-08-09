# Benchmark runner for the rotblocks cipher.

source ./ciphers/rotblocks/cipher.sh
source ./ciphers/rotblocks/keys.sh

rotblocks_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(rotblocks_encrypt "$sample")
  done
  echo "${#out}"
}

rotblocks_bench_label() {
  echo "rotblocks x${1:-16}"
}
