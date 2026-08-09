# Benchmark runner for the scytale cipher.

source ./ciphers/scytale/cipher.sh
source ./ciphers/scytale/keys.sh

scytale_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(scytale_encrypt "$sample")
  done
  echo "${#out}"
}

scytale_bench_label() {
  echo "scytale x${1:-16}"
}
