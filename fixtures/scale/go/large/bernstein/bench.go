package bernstein

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// BernsteinMeasure times a single digest run over sample and packages the
// result for reporting.
func BernsteinMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return BernsteinDigest(sample)
	})
	return entry.NewEntry(BernsteinName, digest, elapsed, len(sample))
}
