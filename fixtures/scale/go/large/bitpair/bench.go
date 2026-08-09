package bitpair

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// BitpairMeasure times a single digest run over sample and packages the
// result for reporting.
func BitpairMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return BitpairDigest(sample)
	})
	return entry.NewEntry(BitpairName, digest, elapsed, len(sample))
}
