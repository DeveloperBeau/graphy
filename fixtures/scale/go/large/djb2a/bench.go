package djb2a

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Djb2aMeasure times a single digest run over sample and packages the
// result for reporting.
func Djb2aMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Djb2aDigest(sample)
	})
	return entry.NewEntry(Djb2aName, digest, elapsed, len(sample))
}
