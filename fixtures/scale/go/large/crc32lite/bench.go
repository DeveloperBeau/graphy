package crc32lite

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Crc32liteMeasure times a single digest run over sample and packages the
// result for reporting.
func Crc32liteMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Crc32liteDigest(sample)
	})
	return entry.NewEntry(Crc32liteName, digest, elapsed, len(sample))
}
