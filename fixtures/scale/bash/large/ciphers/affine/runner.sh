# Benchmark runner for the affine cipher.

source ./ciphers/affine/cipher.sh
source ./ciphers/affine/keys.sh

affine_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(affine_encrypt "$sample")
  done
  echo "${#out}"
}

affine_bench_label() {
  echo "affine x${1:-16}"
}
