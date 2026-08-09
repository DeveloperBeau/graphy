# Benchmark runner for the decimation cipher.

source ./ciphers/decimation/cipher.sh
source ./ciphers/decimation/keys.sh

decimation_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(decimation_encrypt "$sample")
  done
  echo "${#out}"
}

decimation_bench_label() {
  echo "decimation x${1:-16}"
}
