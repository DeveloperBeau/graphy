package murmur2lite

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Murmur2liteMeasure times a single digest run over sample and packages the
// result for reporting.
func Murmur2liteMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Murmur2liteDigest(sample)
	})
	return entry.NewEntry(Murmur2liteName, digest, elapsed, len(sample))
}
