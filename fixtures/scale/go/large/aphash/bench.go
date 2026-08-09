package aphash

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// AphashMeasure times a single digest run over sample and packages the
// result for reporting.
func AphashMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return AphashDigest(sample)
	})
	return entry.NewEntry(AphashName, digest, elapsed, len(sample))
}
