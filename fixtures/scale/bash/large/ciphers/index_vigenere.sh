# Load and register the vigenere cipher family.

source ./ciphers/vigenere/runner.sh
source ./ciphers/vigenere/check.sh
source ./ciphers/beaufort/runner.sh
source ./ciphers/beaufort/check.sh
source ./ciphers/autokey/runner.sh
source ./ciphers/autokey/check.sh
source ./ciphers/gronsfeld/runner.sh
source ./ciphers/gronsfeld/check.sh
source ./ciphers/porta/runner.sh
source ./ciphers/porta/check.sh
source ./ciphers/runkey/runner.sh
source ./ciphers/runkey/check.sh
source ./ciphers/keymix/runner.sh
source ./ciphers/keymix/check.sh
source ./ciphers/trithemius/runner.sh
source ./ciphers/trithemius/check.sh
source ./ciphers/quagmire/runner.sh
source ./ciphers/quagmire/check.sh

vigenere_register_all() {
  register_cipher vigenere
  register_cipher beaufort
  register_cipher autokey
  register_cipher gronsfeld
  register_cipher porta
  register_cipher runkey
  register_cipher keymix
  register_cipher trithemius
  register_cipher quagmire
}
