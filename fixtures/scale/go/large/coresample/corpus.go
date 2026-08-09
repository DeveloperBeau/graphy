package coresample

// BuildCorpus concatenates the sample words into a single byte slice
// large enough to exercise every hash family.
func BuildCorpus() []byte {
	var out []byte
	for i := 0; i < len(SampleWords)*4; i++ {
		out = append(out, SampleWord(i)...)
		out = append(out, ' ')
	}
	return out
}
