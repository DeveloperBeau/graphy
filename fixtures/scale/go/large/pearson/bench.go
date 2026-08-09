package pearson

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// PearsonMeasure times a single digest run over sample and packages the
// result for reporting.
func PearsonMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return PearsonDigest(sample)
	})
	return entry.NewEntry(PearsonName, digest, elapsed, len(sample))
}
