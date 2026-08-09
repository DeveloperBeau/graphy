package murmurlite

// MurmurliteVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func MurmurliteVerify() bool {
	a := MurmurliteDigest([]byte("hashbench"))
	b := MurmurliteDigest([]byte("hashbench"))
	c := MurmurliteDigest([]byte("hashbench!"))
	return a == b && a != c
}
