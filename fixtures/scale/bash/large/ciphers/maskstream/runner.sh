# Benchmark runner for the maskstream cipher.

source ./ciphers/maskstream/cipher.sh
source ./ciphers/maskstream/keys.sh

maskstream_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(maskstream_encrypt "$sample")
  done
  echo "${#out}"
}

maskstream_bench_label() {
  echo "maskstream x${1:-16}"
}
