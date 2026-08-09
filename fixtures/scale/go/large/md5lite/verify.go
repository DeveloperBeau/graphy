package md5lite

// Md5liteVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Md5liteVerify() bool {
	a := Md5liteDigest([]byte("hashbench"))
	b := Md5liteDigest([]byte("hashbench"))
	c := Md5liteDigest([]byte("hashbench!"))
	return a == b && a != c
}
