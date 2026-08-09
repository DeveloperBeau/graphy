# Benchmark runner for the xorbasic cipher.

source ./ciphers/xorbasic/cipher.sh
source ./ciphers/xorbasic/keys.sh

xorbasic_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(xorbasic_encrypt "$sample")
  done
  echo "${#out}"
}

xorbasic_bench_label() {
  echo "xorbasic x${1:-16}"
}
