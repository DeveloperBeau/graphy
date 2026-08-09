package corebytes

// BytesToUint64LE interprets up to the first 8 bytes of b as a
// little-endian uint64, zero-padding short inputs.
func BytesToUint64LE(b []byte) uint64 {
	var v uint64
	for i := 0; i < 8 && i < len(b); i++ {
		v |= uint64(b[i]) << (8 * uint(i))
	}
	return v
}

// BytesToUint32LE interprets up to the first 4 bytes of b as a
// little-endian uint32, zero-padding short inputs.
func BytesToUint32LE(b []byte) uint32 {
	var v uint32
	for i := 0; i < 4 && i < len(b); i++ {
		v |= uint32(b[i]) << (8 * uint(i))
	}
	return v
}
