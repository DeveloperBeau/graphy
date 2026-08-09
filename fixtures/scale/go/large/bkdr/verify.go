package bkdr

// BkdrVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func BkdrVerify() bool {
	a := BkdrDigest([]byte("hashbench"))
	b := BkdrDigest([]byte("hashbench"))
	c := BkdrDigest([]byte("hashbench!"))
	return a == b && a != c
}
