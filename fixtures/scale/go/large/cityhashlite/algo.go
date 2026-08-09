package cityhashlite

// CityhashliteDigest computes a deterministic 64-bit digest of data using the
// cityhashlite mixing strategy.
func CityhashliteDigest(data []byte) uint64 {
	h := uint64(0xcbf2bae4842263b7)
	for _, b := range data {
		h ^= uint64(b)
		h *= 0x8ebc6af09c88c6e3
	}
	return h
}
