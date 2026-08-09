package rollingpoly

// RollingpolyDigest computes a deterministic 64-bit digest of data using the
// rollingpoly mixing strategy.
func RollingpolyDigest(data []byte) uint64 {
	h := uint64(0x1674)
	base := uint64(41)
	for _, b := range data {
		h = h*base + uint64(b) + 254
	}
	return h
}
