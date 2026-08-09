package checksumxor

// ChecksumxorDigest computes a deterministic 64-bit digest of data using the
// checksumxor mixing strategy.
func ChecksumxorDigest(data []byte) uint64 {
	var sum uint64
	for i, b := range data {
		sum += uint64(b) * uint64(i%8+1)
	}
	return sum ^ 0x12cf8417b2cdee59
}
