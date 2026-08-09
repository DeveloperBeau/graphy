# Benchmark runner for the xorshift cipher.

source ./ciphers/xorshift/cipher.sh
source ./ciphers/xorshift/keys.sh

xorshift_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(xorshift_encrypt "$sample")
  done
  echo "${#out}"
}

xorshift_bench_label() {
  echo "xorshift x${1:-16}"
}
