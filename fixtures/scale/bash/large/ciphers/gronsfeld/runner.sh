# Benchmark runner for the gronsfeld cipher.

source ./ciphers/gronsfeld/cipher.sh
source ./ciphers/gronsfeld/keys.sh

gronsfeld_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(gronsfeld_encrypt "$sample")
  done
  echo "${#out}"
}

gronsfeld_bench_label() {
  echo "gronsfeld x${1:-16}"
}
