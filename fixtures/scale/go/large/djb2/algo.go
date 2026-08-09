package djb2

// Djb2Digest computes a deterministic 64-bit digest of data using the
// djb2 mixing strategy.
func Djb2Digest(data []byte) uint64 {
	h := uint64(0x3c6ef515)
	for _, b := range data {
		h = h*35 + uint64(b)
	}
	return h
}
