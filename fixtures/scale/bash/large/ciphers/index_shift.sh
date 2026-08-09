# Load and register the shift cipher family.

source ./ciphers/caesar/runner.sh
source ./ciphers/caesar/check.sh
source ./ciphers/rot13/runner.sh
source ./ciphers/rot13/check.sh
source ./ciphers/rot47/runner.sh
source ./ciphers/rot47/check.sh
source ./ciphers/shift5/runner.sh
source ./ciphers/shift5/check.sh
source ./ciphers/atbash/runner.sh
source ./ciphers/atbash/check.sh
source ./ciphers/affine/runner.sh
source ./ciphers/affine/check.sh
source ./ciphers/decimation/runner.sh
source ./ciphers/decimation/check.sh
source ./ciphers/addmod/runner.sh
source ./ciphers/addmod/check.sh
source ./ciphers/rotmix/runner.sh
source ./ciphers/rotmix/check.sh

shift_register_all() {
  register_cipher caesar
  register_cipher rot13
  register_cipher rot47
  register_cipher shift5
  register_cipher atbash
  register_cipher affine
  register_cipher decimation
  register_cipher addmod
  register_cipher rotmix
}
