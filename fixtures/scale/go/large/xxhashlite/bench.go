package xxhashlite

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// XxhashliteMeasure times a single digest run over sample and packages the
// result for reporting.
func XxhashliteMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return XxhashliteDigest(sample)
	})
	return entry.NewEntry(XxhashliteName, digest, elapsed, len(sample))
}
