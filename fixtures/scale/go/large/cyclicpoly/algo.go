package cyclicpoly

// CyclicpolyDigest computes a deterministic 64-bit digest of data using the
// cyclicpoly mixing strategy.
func CyclicpolyDigest(data []byte) uint64 {
	h := uint64(0x9025)
	base := uint64(31)
	for _, b := range data {
		h = h*base + uint64(b) + 139
	}
	return h
}
