package splitmix64

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Splitmix64Measure times a single digest run over sample and packages the
// result for reporting.
func Splitmix64Measure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Splitmix64Digest(sample)
	})
	return entry.NewEntry(Splitmix64Name, digest, elapsed, len(sample))
}
