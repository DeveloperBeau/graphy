# Load and register the hash cipher family.

source ./ciphers/fnv1a/runner.sh
source ./ciphers/fnv1a/check.sh
source ./ciphers/djb2/runner.sh
source ./ciphers/djb2/check.sh
source ./ciphers/sdbm/runner.sh
source ./ciphers/sdbm/check.sh
source ./ciphers/adler/runner.sh
source ./ciphers/adler/check.sh
source ./ciphers/sum32/runner.sh
source ./ciphers/sum32/check.sh
source ./ciphers/xordigest/runner.sh
source ./ciphers/xordigest/check.sh
source ./ciphers/crclite/runner.sh
source ./ciphers/crclite/check.sh
source ./ciphers/rothash/runner.sh
source ./ciphers/rothash/check.sh
source ./ciphers/prodhash/runner.sh
source ./ciphers/prodhash/check.sh

hash_register_all() {
  register_cipher fnv1a
  register_cipher djb2
  register_cipher sdbm
  register_cipher adler
  register_cipher sum32
  register_cipher xordigest
  register_cipher crclite
  register_cipher rothash
  register_cipher prodhash
}
