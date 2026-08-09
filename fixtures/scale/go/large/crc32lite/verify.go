package crc32lite

// Crc32liteVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Crc32liteVerify() bool {
	a := Crc32liteDigest([]byte("hashbench"))
	b := Crc32liteDigest([]byte("hashbench"))
	c := Crc32liteDigest([]byte("hashbench!"))
	return a == b && a != c
}
