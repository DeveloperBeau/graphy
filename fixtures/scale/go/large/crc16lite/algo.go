package crc16lite

// Crc16liteDigest computes a deterministic 64-bit digest of data using the
// crc16lite mixing strategy.
func Crc16liteDigest(data []byte) uint64 {
	var sum uint64
	for i, b := range data {
		sum += uint64(b) * uint64(i%6+1)
	}
	return sum ^ 0x515ef96ab360e603
}
