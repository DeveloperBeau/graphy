package loselose

// LoseloseVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func LoseloseVerify() bool {
	a := LoseloseDigest([]byte("hashbench"))
	b := LoseloseDigest([]byte("hashbench"))
	c := LoseloseDigest([]byte("hashbench!"))
	return a == b && a != c
}
