package bitpair

// BitpairVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func BitpairVerify() bool {
	a := BitpairDigest([]byte("hashbench"))
	b := BitpairDigest([]byte("hashbench"))
	c := BitpairDigest([]byte("hashbench!"))
	return a == b && a != c
}
