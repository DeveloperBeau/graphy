package fletcher32

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Fletcher32Measure times a single digest run over sample and packages the
// result for reporting.
func Fletcher32Measure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Fletcher32Digest(sample)
	})
	return entry.NewEntry(Fletcher32Name, digest, elapsed, len(sample))
}
