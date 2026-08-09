package djb2a

// Djb2aDigest computes a deterministic 64-bit digest of data using the
// djb2a mixing strategy.
func Djb2aDigest(data []byte) uint64 {
	h := uint64(0xdaa66ec6)
	for _, b := range data {
		h = h*37 + uint64(b)
	}
	return h
}
