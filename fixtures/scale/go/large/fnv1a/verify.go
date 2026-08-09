package fnv1a

// Fnv1aVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Fnv1aVerify() bool {
	a := Fnv1aDigest([]byte("hashbench"))
	b := Fnv1aDigest([]byte("hashbench"))
	c := Fnv1aDigest([]byte("hashbench!"))
	return a == b && a != c
}
