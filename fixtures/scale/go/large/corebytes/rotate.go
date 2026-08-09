package corebytes

// RotateLeft64 rotates a 64-bit value left by n bits.
func RotateLeft64(x uint64, n uint) uint64 {
	n %= 64
	return (x << n) | (x >> (64 - n))
}

// RotateRight64 rotates a 64-bit value right by n bits.
func RotateRight64(x uint64, n uint) uint64 {
	n %= 64
	return (x >> n) | (x << (64 - n))
}

// RotateLeft32 rotates a 32-bit value left by n bits.
func RotateLeft32(x uint32, n uint) uint32 {
	n %= 32
	return (x << n) | (x >> (32 - n))
}
