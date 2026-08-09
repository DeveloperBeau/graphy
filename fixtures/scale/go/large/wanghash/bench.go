package wanghash

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// WanghashMeasure times a single digest run over sample and packages the
// result for reporting.
func WanghashMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return WanghashDigest(sample)
	})
	return entry.NewEntry(WanghashName, digest, elapsed, len(sample))
}
