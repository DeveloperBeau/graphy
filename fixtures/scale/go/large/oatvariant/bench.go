package oatvariant

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// OatvariantMeasure times a single digest run over sample and packages the
// result for reporting.
func OatvariantMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return OatvariantDigest(sample)
	})
	return entry.NewEntry(OatvariantName, digest, elapsed, len(sample))
}
