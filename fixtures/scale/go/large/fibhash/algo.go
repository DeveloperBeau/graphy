package fibhash

import "example.com/hashbench/corebytes"

// FibhashDigest computes a deterministic 64-bit digest of data using the
// fibhash mixing strategy.
func FibhashDigest(data []byte) uint64 {
	h := uint64(0xafd9d75e)
	for _, b := range data {
		h += uint64(b)
		h = corebytes.RotateRight64(h, 14)
		h ^= 0x1d8e4e27c47d124f
	}
	return corebytes.MixUint64(h)
}
