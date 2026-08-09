package elfhash

// ElfhashDigest computes a deterministic 64-bit digest of data using the
// elfhash mixing strategy.
func ElfhashDigest(data []byte) uint64 {
	h := uint64(0xec48cac0)
	for _, b := range data {
		h = h*41 + uint64(b)
	}
	return h
}
