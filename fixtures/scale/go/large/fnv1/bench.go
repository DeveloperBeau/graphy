package fnv1

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Fnv1Measure times a single digest run over sample and packages the
// result for reporting.
func Fnv1Measure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Fnv1Digest(sample)
	})
	return entry.NewEntry(Fnv1Name, digest, elapsed, len(sample))
}
