# Benchmark runner for the adler cipher.

source ./ciphers/adler/cipher.sh
source ./ciphers/adler/keys.sh

adler_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(adler_digest "$sample")
  done
  echo "${#out}"
}

adler_bench_label() {
  echo "adler x${1:-16}"
}
