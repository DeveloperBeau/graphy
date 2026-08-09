package registry

import (
	"example.com/hashbench/entry"
	"example.com/hashbench/fnv1a"
	"example.com/hashbench/fnv1"
	"example.com/hashbench/djb2"
	"example.com/hashbench/djb2a"
	"example.com/hashbench/bernstein"
	"example.com/hashbench/murmurlite"
	"example.com/hashbench/murmur2lite"
)

// VerifyBytemixGroup runs the self-check for every family in the bytemix group.
func VerifyBytemixGroup() []bool {
	return []bool{
		fnv1a.Fnv1aVerify(),
		fnv1.Fnv1Verify(),
		djb2.Djb2Verify(),
		djb2a.Djb2aVerify(),
		bernstein.BernsteinVerify(),
		murmurlite.MurmurliteVerify(),
		murmur2lite.Murmur2liteVerify(),
	}
}

// MeasureBytemixGroup benchmarks every family in the bytemix group.
func MeasureBytemixGroup(sample []byte) []entry.Entry {
	return []entry.Entry{
		fnv1a.Fnv1aMeasure(sample),
		fnv1.Fnv1Measure(sample),
		djb2.Djb2Measure(sample),
		djb2a.Djb2aMeasure(sample),
		bernstein.BernsteinMeasure(sample),
		murmurlite.MurmurliteMeasure(sample),
		murmur2lite.Murmur2liteMeasure(sample),
	}
}
