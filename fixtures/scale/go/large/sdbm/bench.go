package sdbm

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// SdbmMeasure times a single digest run over sample and packages the
// result for reporting.
func SdbmMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return SdbmDigest(sample)
	})
	return entry.NewEntry(SdbmName, digest, elapsed, len(sample))
}
