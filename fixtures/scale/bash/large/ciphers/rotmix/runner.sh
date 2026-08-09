# Benchmark runner for the rotmix cipher.

source ./ciphers/rotmix/cipher.sh
source ./ciphers/rotmix/keys.sh

rotmix_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(rotmix_encrypt "$sample")
  done
  echo "${#out}"
}

rotmix_bench_label() {
  echo "rotmix x${1:-16}"
}
