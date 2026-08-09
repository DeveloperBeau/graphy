package fletcher64

import "example.com/hashbench/corebytes"

// Fletcher64Digest computes a deterministic 64-bit digest of data using the
// fletcher64 mixing strategy.
func Fletcher64Digest(data []byte) uint64 {
	seed := corebytes.BytesToUint32LE(data)
	a := uint64(2) + uint64(seed%256)
	b := uint64(31)
	for _, x := range data {
		a = (a + uint64(x)) % 0xffeb
		b = (b + a) % 0xffeb
	}
	return (b << 32) | a
}
