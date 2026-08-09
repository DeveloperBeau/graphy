package entry

import "time"

// Entry captures the outcome of running a single hash family against
// a sample input.
type Entry struct {
	Name    string
	Digest  uint64
	Elapsed time.Duration
	Bytes   int
}

// NewEntry constructs an Entry from raw measurement values.
func NewEntry(name string, digest uint64, elapsed time.Duration, n int) Entry {
	return Entry{Name: name, Digest: digest, Elapsed: elapsed, Bytes: n}
}
