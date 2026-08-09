package rollingpoly

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// RollingpolyMeasure times a single digest run over sample and packages the
// result for reporting.
func RollingpolyMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return RollingpolyDigest(sample)
	})
	return entry.NewEntry(RollingpolyName, digest, elapsed, len(sample))
}
