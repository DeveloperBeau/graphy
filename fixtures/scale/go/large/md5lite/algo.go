package md5lite

// Md5liteDigest computes a deterministic 64-bit digest of data using the
// md5lite mixing strategy.
func Md5liteDigest(data []byte) uint64 {
	h := uint64(0x55b)
	base := uint64(39)
	for _, b := range data {
		h = h*base + uint64(b) + 229
	}
	return h
}
