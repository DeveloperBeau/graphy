package siphashlite

// SiphashliteVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func SiphashliteVerify() bool {
	a := SiphashliteDigest([]byte("hashbench"))
	b := SiphashliteDigest([]byte("hashbench"))
	c := SiphashliteDigest([]byte("hashbench!"))
	return a == b && a != c
}
