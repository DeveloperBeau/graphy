# Benchmark runner for the rc4lite cipher.

source ./ciphers/rc4lite/cipher.sh
source ./ciphers/rc4lite/keys.sh

rc4lite_run_bench() {
  local sample="$1" rounds="${2:-16}" r out
  for (( r = 0; r < rounds; r++ )); do
    out=$(rc4lite_encrypt "$sample")
  done
  echo "${#out}"
}

rc4lite_bench_label() {
  echo "rc4lite x${1:-16}"
}
