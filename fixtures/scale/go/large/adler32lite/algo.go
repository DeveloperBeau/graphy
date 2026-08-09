package adler32lite

import "example.com/hashbench/corebytes"

// Adler32liteDigest computes a deterministic 64-bit digest of data using the
// adler32lite mixing strategy.
func Adler32liteDigest(data []byte) uint64 {
	seed := corebytes.BytesToUint32LE(data)
	a := uint64(8) + uint64(seed%256)
	b := uint64(24)
	for _, x := range data {
		a = (a + uint64(x)) % 0xffe3
		b = (b + a) % 0xffe3
	}
	return (b << 32) | a
}
