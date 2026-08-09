package elfhash

// ElfhashVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func ElfhashVerify() bool {
	a := ElfhashDigest([]byte("hashbench"))
	b := ElfhashDigest([]byte("hashbench"))
	c := ElfhashDigest([]byte("hashbench!"))
	return a == b && a != c
}
