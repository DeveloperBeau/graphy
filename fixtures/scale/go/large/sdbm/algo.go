package sdbm

// SdbmDigest computes a deterministic 64-bit digest of data using the
// sdbm mixing strategy.
func SdbmDigest(data []byte) uint64 {
	h := uint64(0x9d6)
	for _, b := range data {
		h = uint64(b) + (h << 9) + (h << 15) - h
	}
	return h
}
