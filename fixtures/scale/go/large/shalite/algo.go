package shalite

// ShaliteDigest computes a deterministic 64-bit digest of data using the
// shalite mixing strategy.
func ShaliteDigest(data []byte) uint64 {
	h := uint64(0x7f0c)
	base := uint64(41)
	for _, b := range data {
		h = h*base + uint64(b) + 182
	}
	return h
}
