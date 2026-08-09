package xorshift32

import "example.com/hashbench/corebytes"

// Xorshift32Digest computes a deterministic 64-bit digest of data using the
// xorshift32 mixing strategy.
func Xorshift32Digest(data []byte) uint64 {
	h := uint64(0x10e36fbf09a)
	for _, b := range data {
		h ^= uint64(b)
		h = corebytes.RotateLeft64(h, 49)
		h *= 0xa24baed4963ee407
	}
	return corebytes.MixUint64(h)
}
