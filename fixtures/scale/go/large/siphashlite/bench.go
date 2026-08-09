package siphashlite

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// SiphashliteMeasure times a single digest run over sample and packages the
// result for reporting.
func SiphashliteMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return SiphashliteDigest(sample)
	})
	return entry.NewEntry(SiphashliteName, digest, elapsed, len(sample))
}
