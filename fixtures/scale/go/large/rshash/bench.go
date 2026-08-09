package rshash

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// RshashMeasure times a single digest run over sample and packages the
// result for reporting.
func RshashMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return RshashDigest(sample)
	})
	return entry.NewEntry(RshashName, digest, elapsed, len(sample))
}
