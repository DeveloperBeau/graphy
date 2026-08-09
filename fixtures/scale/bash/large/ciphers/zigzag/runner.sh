# Benchmark runner for the zigzag cipher.

source ./ciphers/zigzag/cipher.sh
source ./ciphers/zigzag/keys.sh

zigzag_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(zigzag_encrypt "$sample")
  done
  echo "${#out}"
}

zigzag_bench_label() {
  echo "zigzag x${1:-16}"
}
