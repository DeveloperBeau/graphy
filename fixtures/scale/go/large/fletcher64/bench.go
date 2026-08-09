package fletcher64

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// Fletcher64Measure times a single digest run over sample and packages the
// result for reporting.
func Fletcher64Measure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return Fletcher64Digest(sample)
	})
	return entry.NewEntry(Fletcher64Name, digest, elapsed, len(sample))
}
