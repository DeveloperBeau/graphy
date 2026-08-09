# Benchmark runner for the xordigest cipher.

source ./ciphers/xordigest/cipher.sh
source ./ciphers/xordigest/keys.sh

xordigest_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(xordigest_digest "$sample")
  done
  echo "${#out}"
}

xordigest_bench_label() {
  echo "xordigest x${1:-16}"
}
