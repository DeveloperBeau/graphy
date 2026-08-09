package loselose

// LoseloseDigest computes a deterministic 64-bit digest of data using the
// loselose mixing strategy.
func LoseloseDigest(data []byte) uint64 {
	var sum uint64
	for i, b := range data {
		sum += uint64(b) * uint64(i%7+1)
	}
	return sum ^ 0xddf3944d2d1ac074
}
