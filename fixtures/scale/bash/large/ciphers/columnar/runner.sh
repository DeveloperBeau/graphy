# Benchmark runner for the columnar cipher.

source ./ciphers/columnar/cipher.sh
source ./ciphers/columnar/keys.sh

columnar_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(columnar_encrypt "$sample")
  done
  echo "${#out}"
}

columnar_bench_label() {
  echo "columnar x${1:-16}"
}
