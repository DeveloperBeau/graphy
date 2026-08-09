package jenkinsoat

// JenkinsoatVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func JenkinsoatVerify() bool {
	a := JenkinsoatDigest([]byte("hashbench"))
	b := JenkinsoatDigest([]byte("hashbench"))
	c := JenkinsoatDigest([]byte("hashbench!"))
	return a == b && a != c
}
