package sdslhash

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// SdslhashMeasure times a single digest run over sample and packages the
// result for reporting.
func SdslhashMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return SdslhashDigest(sample)
	})
	return entry.NewEntry(SdslhashName, digest, elapsed, len(sample))
}
