package bkdr

// BkdrDigest computes a deterministic 64-bit digest of data using the
// bkdr mixing strategy.
func BkdrDigest(data []byte) uint64 {
	h := uint64(0x5c558387)
	for _, b := range data {
		h = h*35 + uint64(b)
	}
	return h
}
