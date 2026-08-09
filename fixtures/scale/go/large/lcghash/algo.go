package lcghash

import "example.com/hashbench/corebytes"

// LcghashDigest computes a deterministic 64-bit digest of data using the
// lcghash mixing strategy.
func LcghashDigest(data []byte) uint64 {
	h := uint64(0x11a25dad)
	for _, b := range data {
		h = h*0x589965cc75374cc3 + uint64(b) + 61747
		h = corebytes.RotateRight64(h, 7)
	}
	return h
}
