package sdslhash

// SdslhashVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func SdslhashVerify() bool {
	a := SdslhashDigest([]byte("hashbench"))
	b := SdslhashDigest([]byte("hashbench"))
	c := SdslhashDigest([]byte("hashbench!"))
	return a == b && a != c
}
