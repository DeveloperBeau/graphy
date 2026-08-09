# Benchmark runner for the rot47 cipher.

source ./ciphers/rot47/cipher.sh
source ./ciphers/rot47/keys.sh

rot47_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(rot47_encrypt "$sample")
  done
  echo "${#out}"
}

rot47_bench_label() {
  echo "rot47 x${1:-16}"
}
