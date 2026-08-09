package pjwhash

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// PjwhashMeasure times a single digest run over sample and packages the
// result for reporting.
func PjwhashMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return PjwhashDigest(sample)
	})
	return entry.NewEntry(PjwhashName, digest, elapsed, len(sample))
}
