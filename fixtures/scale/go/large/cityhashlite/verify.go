package cityhashlite

// CityhashliteVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func CityhashliteVerify() bool {
	a := CityhashliteDigest([]byte("hashbench"))
	b := CityhashliteDigest([]byte("hashbench"))
	c := CityhashliteDigest([]byte("hashbench!"))
	return a == b && a != c
}
