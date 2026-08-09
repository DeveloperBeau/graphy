package fletcher16

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Fletcher16Measure times a single digest run over sample and packages the
// result for reporting.
func Fletcher16Measure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Fletcher16Digest(sample)
	})
	return entry.NewEntry(Fletcher16Name, digest, elapsed, len(sample))
}
