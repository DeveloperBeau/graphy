package pjwhash

// PjwhashDigest computes a deterministic 64-bit digest of data using the
// pjwhash mixing strategy.
func PjwhashDigest(data []byte) uint64 {
	h := uint64(0x8a804471)
	for _, b := range data {
		h = h*31 + uint64(b)
	}
	return h
}
