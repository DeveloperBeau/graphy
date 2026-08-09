package lcghash

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// LcghashMeasure times a single digest run over sample and packages the
// result for reporting.
func LcghashMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return LcghashDigest(sample)
	})
	return entry.NewEntry(LcghashName, digest, elapsed, len(sample))
}
