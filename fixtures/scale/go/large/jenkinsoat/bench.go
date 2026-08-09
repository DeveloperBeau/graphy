package jenkinsoat

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// JenkinsoatMeasure times a single digest run over sample and packages the
// result for reporting.
func JenkinsoatMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return JenkinsoatDigest(sample)
	})
	return entry.NewEntry(JenkinsoatName, digest, elapsed, len(sample))
}
