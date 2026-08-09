package wanghash

// WanghashVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func WanghashVerify() bool {
	a := WanghashDigest([]byte("hashbench"))
	b := WanghashDigest([]byte("hashbench"))
	c := WanghashDigest([]byte("hashbench!"))
	return a == b && a != c
}
