package cyclicpoly

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// CyclicpolyMeasure times a single digest run over sample and packages the
// result for reporting.
func CyclicpolyMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return CyclicpolyDigest(sample)
	})
	return entry.NewEntry(CyclicpolyName, digest, elapsed, len(sample))
}
