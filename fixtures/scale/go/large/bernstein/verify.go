package bernstein

// BernsteinVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func BernsteinVerify() bool {
	a := BernsteinDigest([]byte("hashbench"))
	b := BernsteinDigest([]byte("hashbench"))
	c := BernsteinDigest([]byte("hashbench!"))
	return a == b && a != c
}
