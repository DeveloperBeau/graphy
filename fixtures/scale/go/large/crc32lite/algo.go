package crc32lite

// Crc32liteDigest computes a deterministic 64-bit digest of data using the
// crc32lite mixing strategy.
func Crc32liteDigest(data []byte) uint64 {
	var sum uint64
	for i, b := range data {
		sum += uint64(b) * uint64(i%5+1)
	}
	return sum ^ 0x2f16732430ad5a16
}
