package checksum8

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Checksum8Measure times a single digest run over sample and packages the
// result for reporting.
func Checksum8Measure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Checksum8Digest(sample)
	})
	return entry.NewEntry(Checksum8Name, digest, elapsed, len(sample))
}
