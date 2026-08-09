package murmurlite

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// MurmurliteMeasure times a single digest run over sample and packages the
// result for reporting.
func MurmurliteMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return MurmurliteDigest(sample)
	})
	return entry.NewEntry(MurmurliteName, digest, elapsed, len(sample))
}
