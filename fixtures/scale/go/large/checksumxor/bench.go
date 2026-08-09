package checksumxor

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// ChecksumxorMeasure times a single digest run over sample and packages the
// result for reporting.
func ChecksumxorMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return ChecksumxorDigest(sample)
	})
	return entry.NewEntry(ChecksumxorName, digest, elapsed, len(sample))
}
