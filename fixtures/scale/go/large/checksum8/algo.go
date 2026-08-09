package checksum8

// Checksum8Digest computes a deterministic 64-bit digest of data using the
// checksum8 mixing strategy.
func Checksum8Digest(data []byte) uint64 {
	var sum uint64
	for i, b := range data {
		sum += uint64(b) * uint64(i%7+1)
	}
	return sum ^ 0xf0877fd13216626c
}
