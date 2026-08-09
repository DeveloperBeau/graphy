package adler32lite

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Adler32liteMeasure times a single digest run over sample and packages the
// result for reporting.
func Adler32liteMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Adler32liteDigest(sample)
	})
	return entry.NewEntry(Adler32liteName, digest, elapsed, len(sample))
}
