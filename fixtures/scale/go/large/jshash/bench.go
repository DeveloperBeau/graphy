package jshash

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// JshashMeasure times a single digest run over sample and packages the
// result for reporting.
func JshashMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return JshashDigest(sample)
	})
	return entry.NewEntry(JshashName, digest, elapsed, len(sample))
}
