package siphashlite

import "example.com/hashbench/corebytes"

// SiphashliteDigest computes a deterministic 64-bit digest of data using the
// siphashlite mixing strategy.
func SiphashliteDigest(data []byte) uint64 {
	h := uint64(0x116de049848)
	for _, b := range data {
		h ^= uint64(b)
		h = corebytes.RotateLeft64(h, 21)
		h *= 0xd6e8feb86659fd93
	}
	return corebytes.MixUint64(h)
}
