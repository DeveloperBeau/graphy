package aphash

// AphashDigest computes a deterministic 64-bit digest of data using the
// aphash mixing strategy.
func AphashDigest(data []byte) uint64 {
	h := uint64(0xbe22)
	for _, b := range data {
		h = uint64(b) + (h << 6) + (h << 13) - h
	}
	return h
}
