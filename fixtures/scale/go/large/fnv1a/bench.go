package fnv1a

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Fnv1aMeasure times a single digest run over sample and packages the
// result for reporting.
func Fnv1aMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Fnv1aDigest(sample)
	})
	return entry.NewEntry(Fnv1aName, digest, elapsed, len(sample))
}
