# Benchmark runner for the xorroll cipher.

source ./ciphers/xorroll/cipher.sh
source ./ciphers/xorroll/keys.sh

xorroll_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(xorroll_encrypt "$sample")
  done
  echo "${#out}"
}

xorroll_bench_label() {
  echo "xorroll x${1:-16}"
}
