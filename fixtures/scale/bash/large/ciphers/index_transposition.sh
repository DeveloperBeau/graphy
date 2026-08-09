# Load and register the transposition cipher family.

source ./ciphers/railfence/runner.sh
source ./ciphers/railfence/check.sh
source ./ciphers/columnar/runner.sh
source ./ciphers/columnar/check.sh
source ./ciphers/scytale/runner.sh
source ./ciphers/scytale/check.sh
source ./ciphers/revblocks/runner.sh
source ./ciphers/revblocks/check.sh
source ./ciphers/zigzag/runner.sh
source ./ciphers/zigzag/check.sh
source ./ciphers/blockswap/runner.sh
source ./ciphers/blockswap/check.sh
source ./ciphers/rotblocks/runner.sh
source ./ciphers/rotblocks/check.sh
source ./ciphers/interleave/runner.sh
source ./ciphers/interleave/check.sh
source ./ciphers/stride/runner.sh
source ./ciphers/stride/check.sh

transposition_register_all() {
  register_cipher railfence
  register_cipher columnar
  register_cipher scytale
  register_cipher revblocks
  register_cipher zigzag
  register_cipher blockswap
  register_cipher rotblocks
  register_cipher interleave
  register_cipher stride
}
