package xorshift64

import "example.com/hashbench/corebytes"

// Xorshift64Digest computes a deterministic 64-bit digest of data using the
// xorshift64 mixing strategy.
func Xorshift64Digest(data []byte) uint64 {
	h := uint64(0x10d98c476e9)
	for _, b := range data {
		h ^= uint64(b)
		h = corebytes.RotateLeft64(h, 42)
		h *= 0x1d8e4e27c47d124f
	}
	return corebytes.MixUint64(h)
}
