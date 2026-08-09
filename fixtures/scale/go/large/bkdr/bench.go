package bkdr

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// BkdrMeasure times a single digest run over sample and packages the
// result for reporting.
func BkdrMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return BkdrDigest(sample)
	})
	return entry.NewEntry(BkdrName, digest, elapsed, len(sample))
}
