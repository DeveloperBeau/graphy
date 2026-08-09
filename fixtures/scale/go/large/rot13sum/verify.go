package rot13sum

// Rot13sumVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Rot13sumVerify() bool {
	a := Rot13sumDigest([]byte("hashbench"))
	b := Rot13sumDigest([]byte("hashbench"))
	c := Rot13sumDigest([]byte("hashbench!"))
	return a == b && a != c
}
