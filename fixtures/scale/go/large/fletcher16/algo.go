package fletcher16

import "example.com/hashbench/corebytes"

// Fletcher16Digest computes a deterministic 64-bit digest of data using the
// fletcher16 mixing strategy.
func Fletcher16Digest(data []byte) uint64 {
	seed := corebytes.BytesToUint32LE(data)
	a := uint64(13) + uint64(seed%256)
	b := uint64(29)
	for _, x := range data {
		a = (a + uint64(x)) % 0xffef
		b = (b + a) % 0xffef
	}
	return (b << 32) | a
}
