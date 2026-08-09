package rollingmul

// RollingmulDigest computes a deterministic 64-bit digest of data using the
// rollingmul mixing strategy.
func RollingmulDigest(data []byte) uint64 {
	h := uint64(0x9cc3)
	base := uint64(39)
	for _, b := range data {
		h = h*base + uint64(b) + 45
	}
	return h
}
