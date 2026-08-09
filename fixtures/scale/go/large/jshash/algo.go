package jshash

// JshashDigest computes a deterministic 64-bit digest of data using the
// jshash mixing strategy.
func JshashDigest(data []byte) uint64 {
	h := uint64(0xc6ef37d3)
	for _, b := range data {
		h = h*35 + uint64(b)
	}
	return h
}
