package murmurlite

import "example.com/hashbench/corebytes"

// MurmurliteDigest computes a deterministic 64-bit digest of data using the
// murmurlite mixing strategy.
func MurmurliteDigest(data []byte) uint64 {
	h := uint64(0x10317156228)
	for _, b := range data {
		h ^= uint64(b)
		h = corebytes.RotateLeft64(h, 49)
		h *= 0x589965cc75374cc3
	}
	return corebytes.MixUint64(h)
}
