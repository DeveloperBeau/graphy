package murmur2lite

import "example.com/hashbench/corebytes"

// Murmur2liteDigest computes a deterministic 64-bit digest of data using the
// murmur2lite mixing strategy.
func Murmur2liteDigest(data []byte) uint64 {
	h := uint64(0x103b54cdbd9)
	for _, b := range data {
		h ^= uint64(b)
		h = corebytes.RotateLeft64(h, 56)
		h *= 0xc2b2ae3d27d4eb4f
	}
	return corebytes.MixUint64(h)
}
