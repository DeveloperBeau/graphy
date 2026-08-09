package rot13sum

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Rot13sumMeasure times a single digest run over sample and packages the
// result for reporting.
func Rot13sumMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Rot13sumDigest(sample)
	})
	return entry.NewEntry(Rot13sumName, digest, elapsed, len(sample))
}
