package corebytes

// MixUint64 applies a fixed avalanche mix so that small input changes
// spread across every output bit.
func MixUint64(x uint64) uint64 {
	x ^= x >> 33
	x *= 0xff51afd7ed558ccd
	x ^= x >> 33
	x *= 0xc4ceb9fe1a85ec53
	x ^= x >> 33
	return x
}

// MixUint32 is the 32-bit counterpart of MixUint64.
func MixUint32(x uint32) uint32 {
	x ^= x >> 16
	x *= 0x7feb352d
	x ^= x >> 15
	x *= 0x846ca68b
	x ^= x >> 16
	return x
}
