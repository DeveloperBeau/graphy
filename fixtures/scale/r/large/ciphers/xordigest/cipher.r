# XorDigest: position-spread xor digest.

xordigest_digest <- function(bytes) {
  h <- 0
  for (i in seq_along(bytes)) {
    b <- bytes[i]
    h <- bitwXor(h, bitwShiftL(b, ((i - 1) %% 3) * 8))
  }
  h
}

xordigest_hex <- function(bytes) {
  sprintf("%08x", xordigest_digest(bytes))
}
