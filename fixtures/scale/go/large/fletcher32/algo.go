package fletcher32

import "example.com/hashbench/corebytes"

// Fletcher32Digest computes a deterministic 64-bit digest of data using the
// fletcher32 mixing strategy.
func Fletcher32Digest(data []byte) uint64 {
	seed := corebytes.BytesToUint32LE(data)
	a := uint64(1) + uint64(seed%256)
	b := uint64(30)
	for _, x := range data {
		a = (a + uint64(x)) % 0xffed
		b = (b + a) % 0xffed
	}
	return (b << 32) | a
}
