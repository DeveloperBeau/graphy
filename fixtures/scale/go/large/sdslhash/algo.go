package sdslhash

// SdslhashDigest computes a deterministic 64-bit digest of data using the
// sdslhash mixing strategy.
func SdslhashDigest(data []byte) uint64 {
	h := uint64(0xfd38)
	for _, b := range data {
		h = uint64(b) + (h << 6) + (h << 10) - h
	}
	return h
}
