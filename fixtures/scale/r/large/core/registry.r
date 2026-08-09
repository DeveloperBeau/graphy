# Names of every registered cipher, in run order.

.cipher_registry <- new.env()
.cipher_registry$names <- character(0)

register_cipher <- function(name) {
  .cipher_registry$names <- c(.cipher_registry$names, name)
}

registered_ciphers <- function() {
  .cipher_registry$names
}

registered_count <- function() {
  length(.cipher_registry$names)
}
