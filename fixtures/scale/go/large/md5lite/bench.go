package md5lite

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Md5liteMeasure times a single digest run over sample and packages the
// result for reporting.
func Md5liteMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Md5liteDigest(sample)
	})
	return entry.NewEntry(Md5liteName, digest, elapsed, len(sample))
}
