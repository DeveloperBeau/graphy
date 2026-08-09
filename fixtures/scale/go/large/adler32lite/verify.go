package adler32lite

// Adler32liteVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Adler32liteVerify() bool {
	a := Adler32liteDigest([]byte("hashbench"))
	b := Adler32liteDigest([]byte("hashbench"))
	c := Adler32liteDigest([]byte("hashbench!"))
	return a == b && a != c
}
