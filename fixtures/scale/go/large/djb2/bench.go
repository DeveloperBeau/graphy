package djb2

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Djb2Measure times a single digest run over sample and packages the
// result for reporting.
func Djb2Measure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Djb2Digest(sample)
	})
	return entry.NewEntry(Djb2Name, digest, elapsed, len(sample))
}
