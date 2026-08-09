package coresample

// SampleSizes lists the input sizes exercised by the benchmark runner.
var SampleSizes = []int{16, 64, 256, 1024}

// SampleSize returns the size at position i, wrapping around the list.
func SampleSize(i int) int {
	return SampleSizes[i%len(SampleSizes)]
}
