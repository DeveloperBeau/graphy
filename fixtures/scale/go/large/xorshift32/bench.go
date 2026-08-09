package xorshift32

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Xorshift32Measure times a single digest run over sample and packages the
// result for reporting.
func Xorshift32Measure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Xorshift32Digest(sample)
	})
	return entry.NewEntry(Xorshift32Name, digest, elapsed, len(sample))
}
