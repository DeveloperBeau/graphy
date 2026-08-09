package crc16lite

// Crc16liteVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Crc16liteVerify() bool {
	a := Crc16liteDigest([]byte("hashbench"))
	b := Crc16liteDigest([]byte("hashbench"))
	c := Crc16liteDigest([]byte("hashbench!"))
	return a == b && a != c
}
