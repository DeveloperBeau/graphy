# Benchmark runner for the interleave cipher.

source ./ciphers/interleave/cipher.sh
source ./ciphers/interleave/keys.sh

interleave_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(interleave_encrypt "$sample")
  done
  echo "${#out}"
}

interleave_bench_label() {
  echo "interleave x${1:-16}"
}
