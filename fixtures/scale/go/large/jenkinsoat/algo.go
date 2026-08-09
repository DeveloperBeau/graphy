package jenkinsoat

// JenkinsoatDigest computes a deterministic 64-bit digest of data using the
// jenkinsoat mixing strategy.
func JenkinsoatDigest(data []byte) uint64 {
	var h uint64
	for _, b := range data {
		h += uint64(b)
		h += h << 10
		h ^= h >> 6
	}
	h += h << 3
	h ^= h >> 11
	h += h << 15
	return h
}
