package coresample

// SampleWords is a small fixed corpus of words used to build
// deterministic benchmark inputs.
var SampleWords = []string{
	"alpha", "bravo", "charlie", "delta", "echo",
	"foxtrot", "golf", "hotel", "india", "juliet",
}

// SampleWord returns the word at position i, wrapping around the list.
func SampleWord(i int) string {
	return SampleWords[i%len(SampleWords)]
}
