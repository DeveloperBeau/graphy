package rollingadd

// RollingaddDigest computes a deterministic 64-bit digest of data using the
// rollingadd mixing strategy.
func RollingaddDigest(data []byte) uint64 {
	h := uint64(0x2312)
	base := uint64(37)
	for _, b := range data {
		h = h*base + uint64(b) + 96
	}
	return h
}
