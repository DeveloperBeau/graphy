package shalite

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// ShaliteMeasure times a single digest run over sample and packages the
// result for reporting.
func ShaliteMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return ShaliteDigest(sample)
	})
	return entry.NewEntry(ShaliteName, digest, elapsed, len(sample))
}
