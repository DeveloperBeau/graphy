package xorshift64

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Xorshift64Measure times a single digest run over sample and packages the
// result for reporting.
func Xorshift64Measure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Xorshift64Digest(sample)
	})
	return entry.NewEntry(Xorshift64Name, digest, elapsed, len(sample))
}
