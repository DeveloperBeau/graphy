package splitmix64

import "example.com/hashbench/corebytes"

// Splitmix64Digest computes a deterministic 64-bit digest of data using the
// splitmix64 mixing strategy.
func Splitmix64Digest(data []byte) uint64 {
	h := uint64(0xd5336a4b)
	for _, b := range data {
		h += uint64(b)
		h = corebytes.RotateRight64(h, 56)
		h ^= 0xe7037ed1a0b428db
	}
	return corebytes.MixUint64(h)
}
