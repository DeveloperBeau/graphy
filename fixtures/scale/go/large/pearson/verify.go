package pearson

// PearsonVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func PearsonVerify() bool {
	a := PearsonDigest([]byte("hashbench"))
	b := PearsonDigest([]byte("hashbench"))
	c := PearsonDigest([]byte("hashbench!"))
	return a == b && a != c
}
