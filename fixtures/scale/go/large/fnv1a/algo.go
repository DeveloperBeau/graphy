package fnv1a

// Fnv1aDigest computes a deterministic 64-bit digest of data using the
// fnv1a mixing strategy.
func Fnv1aDigest(data []byte) uint64 {
	h := uint64(0xcbf29ce484222325)
	for _, b := range data {
		h ^= uint64(b)
		h *= 0x9fb21c651e98df25
	}
	return h
}
