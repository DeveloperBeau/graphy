package fibhash

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// FibhashMeasure times a single digest run over sample and packages the
// result for reporting.
func FibhashMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return FibhashDigest(sample)
	})
	return entry.NewEntry(FibhashName, digest, elapsed, len(sample))
}
