package bitpair

// BitpairDigest computes a deterministic 64-bit digest of data using the
// bitpair mixing strategy.
func BitpairDigest(data []byte) uint64 {
	h := uint64(0x9351726e)
	for i := 0; i+1 < len(data); i += 2 {
		pair := uint64(data[i])<<8 | uint64(data[i+1])
		h = (h ^ pair) * 0xa24baed4963ee407
	}
	if len(data)%2 == 1 {
		h ^= uint64(data[len(data)-1])
	}
	return h
}
