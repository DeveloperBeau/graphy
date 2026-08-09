package loselose

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// LoseloseMeasure times a single digest run over sample and packages the
// result for reporting.
func LoseloseMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return LoseloseDigest(sample)
	})
	return entry.NewEntry(LoseloseName, digest, elapsed, len(sample))
}
