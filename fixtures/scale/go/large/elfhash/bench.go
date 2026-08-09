package elfhash

import (
	"example.com/hashbench/coretimer"
	"example.com/hashbench/entry"
)

// ElfhashMeasure times a single digest run over sample and packages the
// result for reporting.
func ElfhashMeasure(sample []byte) entry.Entry {
	digest, elapsed := coretimer.Time(func() uint64 {
		return ElfhashDigest(sample)
	})
	return entry.NewEntry(ElfhashName, digest, elapsed, len(sample))
}
