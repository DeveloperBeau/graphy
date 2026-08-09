package rshash

// RshashDigest computes a deterministic 64-bit digest of data using the
// rshash mixing strategy.
func RshashDigest(data []byte) uint64 {
	h := uint64(0xb184)
	for _, b := range data {
		h = uint64(b) + (h << 8) + (h << 15) - h
	}
	return h
}
