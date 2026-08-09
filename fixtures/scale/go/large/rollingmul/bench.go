package rollingmul

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// RollingmulMeasure times a single digest run over sample and packages the
// result for reporting.
func RollingmulMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return RollingmulDigest(sample)
	})
	return entry.NewEntry(RollingmulName, digest, elapsed, len(sample))
}
