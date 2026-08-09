package crc16lite

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Crc16liteMeasure times a single digest run over sample and packages the
// result for reporting.
func Crc16liteMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Crc16liteDigest(sample)
	})
	return entry.NewEntry(Crc16liteName, digest, elapsed, len(sample))
}
