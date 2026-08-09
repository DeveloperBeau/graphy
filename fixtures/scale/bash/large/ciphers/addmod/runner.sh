# Benchmark runner for the addmod cipher.

source ./ciphers/addmod/cipher.sh
source ./ciphers/addmod/keys.sh

addmod_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(addmod_encrypt "$sample")
  done
  echo "${#out}"
}

addmod_bench_label() {
  echo "addmod x${1:-16}"
}
