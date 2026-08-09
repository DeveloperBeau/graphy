package xxhashlite

// XxhashliteVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func XxhashliteVerify() bool {
	a := XxhashliteDigest([]byte("hashbench"))
	b := XxhashliteDigest([]byte("hashbench"))
	c := XxhashliteDigest([]byte("hashbench!"))
	return a == b && a != c
}
