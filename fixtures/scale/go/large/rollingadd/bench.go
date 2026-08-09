package rollingadd

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// RollingaddMeasure times a single digest run over sample and packages the
// result for reporting.
func RollingaddMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return RollingaddDigest(sample)
	})
	return entry.NewEntry(RollingaddName, digest, elapsed, len(sample))
}
