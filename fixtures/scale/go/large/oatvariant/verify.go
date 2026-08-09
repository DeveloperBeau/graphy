package oatvariant

// OatvariantVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func OatvariantVerify() bool {
	a := OatvariantDigest([]byte("hashbench"))
	b := OatvariantDigest([]byte("hashbench"))
	c := OatvariantDigest([]byte("hashbench!"))
	return a == b && a != c
}
