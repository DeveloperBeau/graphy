package bernstein

// BernsteinDigest computes a deterministic 64-bit digest of data using the
// bernstein mixing strategy.
func BernsteinDigest(data []byte) uint64 {
	h := uint64(0x78dde877)
	for _, b := range data {
		h = h*39 + uint64(b)
	}
	return h
}
