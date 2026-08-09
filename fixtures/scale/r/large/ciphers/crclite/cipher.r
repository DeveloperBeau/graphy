# CrcLite: shift-xor checksum.

crclite_digest <- function(bytes) {
  h <- 2147483587
  for (b in bytes) {
    h <- bitwXor(bitwXor(bitwShiftR(h, 1), bitwAnd(h, 1) * 1732584193), b)
  }
  h
}

crclite_hex <- function(bytes) {
  sprintf("%08x", crclite_digest(bytes))
}
