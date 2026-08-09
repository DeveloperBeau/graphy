# Benchmark runner for the trithemius cipher.

source ./ciphers/trithemius/cipher.sh
source ./ciphers/trithemius/keys.sh

trithemius_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(trithemius_encrypt "$sample")
  done
  echo "${#out}"
}

trithemius_bench_label() {
  echo "trithemius x${1:-16}"
}
