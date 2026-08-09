# Load and register the stream cipher family.

source ./ciphers/xorbasic/runner.sh
source ./ciphers/xorbasic/check.sh
source ./ciphers/xorroll/runner.sh
source ./ciphers/xorroll/check.sh
source ./ciphers/rc4lite/runner.sh
source ./ciphers/rc4lite/check.sh
source ./ciphers/lcgstream/runner.sh
source ./ciphers/lcgstream/check.sh
source ./ciphers/xorshift/runner.sh
source ./ciphers/xorshift/check.sh
source ./ciphers/feistel/runner.sh
source ./ciphers/feistel/check.sh
source ./ciphers/cbcxor/runner.sh
source ./ciphers/cbcxor/check.sh
source ./ciphers/ctrxor/runner.sh
source ./ciphers/ctrxor/check.sh
source ./ciphers/maskstream/runner.sh
source ./ciphers/maskstream/check.sh

stream_register_all() {
  register_cipher xorbasic
  register_cipher xorroll
  register_cipher rc4lite
  register_cipher lcgstream
  register_cipher xorshift
  register_cipher feistel
  register_cipher cbcxor
  register_cipher ctrxor
  register_cipher maskstream
}
