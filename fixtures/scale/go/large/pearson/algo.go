package pearson

// PearsonDigest computes a deterministic 64-bit digest of data using the
// pearson mixing strategy.
var PearsonTable = [16]byte{11, 48, 85, 122, 159, 196, 233, 14, 51, 88, 125, 162, 199, 236, 17, 54}

func PearsonDigest(data []byte) uint64 {
	h := byte(228)
	acc := uint64(0)
	for _, b := range data {
		idx := (h ^ b) % 16
		h = PearsonTable[idx]
		acc = (acc << 8) | uint64(h)
	}
	return acc
}
