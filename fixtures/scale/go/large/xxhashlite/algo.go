package xxhashlite

import "example.com/hashbench/corebytes"

// XxhashliteDigest computes a deterministic 64-bit digest of data using the
// xxhashlite mixing strategy.
func XxhashliteDigest(data []byte) uint64 {
	h := uint64(0x1181a738baa)
	for _, b := range data {
		h ^= uint64(b)
		h = corebytes.RotateLeft64(h, 35)
		h *= 0xeb44accab455d165
	}
	return corebytes.MixUint64(h)
}
