package cityhashlite

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// CityhashliteMeasure times a single digest run over sample and packages the
// result for reporting.
func CityhashliteMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return CityhashliteDigest(sample)
	})
	return entry.NewEntry(CityhashliteName, digest, elapsed, len(sample))
}
