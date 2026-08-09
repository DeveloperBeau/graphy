package rot13sum

// Rot13sumDigest computes a deterministic 64-bit digest of data using the
// rot13sum mixing strategy.
func Rot13sumDigest(data []byte) uint64 {
	var sum uint64
	for i, b := range data {
		sum += uint64(b) * uint64(i%3+1)
	}
	return sum ^ 0xe160a0fa2c87c84a
}
