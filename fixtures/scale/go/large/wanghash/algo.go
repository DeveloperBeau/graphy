package wanghash

import "example.com/hashbench/corebytes"

// WanghashDigest computes a deterministic 64-bit digest of data using the
// wanghash mixing strategy.
func WanghashDigest(data []byte) uint64 {
	h := uint64(0x736ae3fc)
	for _, b := range data {
		h += uint64(b)
		h = corebytes.RotateRight64(h, 63)
		h ^= 0x8ebc6af09c88c6e3
	}
	return corebytes.MixUint64(h)
}
