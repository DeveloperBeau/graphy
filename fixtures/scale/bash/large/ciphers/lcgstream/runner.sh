# Benchmark runner for the lcgstream cipher.

source ./ciphers/lcgstream/cipher.sh
source ./ciphers/lcgstream/keys.sh

lcgstream_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(lcgstream_encrypt "$sample")
  done
  echo "${#out}"
}

lcgstream_bench_label() {
  echo "lcgstream x${1:-16}"
}
