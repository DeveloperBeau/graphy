package oatvariant

import "example.com/hashbench/corebytes"

// OatvariantDigest computes a deterministic 64-bit digest of data using the
// oatvariant mixing strategy.
func OatvariantDigest(data []byte) uint64 {
	h := uint64(0x115a195a4e6)
	for _, b := range data {
		h ^= uint64(b)
		h = corebytes.RotateLeft64(h, 7)
		h *= 0x589965cc75374cc3
	}
	return corebytes.MixUint64(h)
}
