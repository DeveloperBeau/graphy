package fnv1

// Fnv1Digest computes a deterministic 64-bit digest of data using the
// fnv1 mixing strategy.
func Fnv1Digest(data []byte) uint64 {
	h := uint64(0xcbf29de484222296)
	for _, b := range data {
		h ^= uint64(b)
		h *= 0xe7037ed1a0b428db
	}
	return h
}
