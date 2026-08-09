package registry

import (
	"example.com/hashbench/entry"
	"example.com/hashbench/xorshift64"
	"example.com/hashbench/xorshift32"
	"example.com/hashbench/splitmix64"
	"example.com/hashbench/wanghash"
	"example.com/hashbench/lcghash"
	"example.com/hashbench/fibhash"
	"example.com/hashbench/pearson"
)

// VerifyMixersGroup runs the self-check for every family in the mixers group.
func VerifyMixersGroup() []bool {
	return []bool{
		xorshift64.Xorshift64Verify(),
		xorshift32.Xorshift32Verify(),
		splitmix64.Splitmix64Verify(),
		wanghash.WanghashVerify(),
		lcghash.LcghashVerify(),
		fibhash.FibhashVerify(),
		pearson.PearsonVerify(),
	}
}

// MeasureMixersGroup benchmarks every family in the mixers group.
func MeasureMixersGroup(sample []byte) []entry.Entry {
	return []entry.Entry{
		xorshift64.Xorshift64Measure(sample),
		xorshift32.Xorshift32Measure(sample),
		splitmix64.Splitmix64Measure(sample),
		wanghash.WanghashMeasure(sample),
		lcghash.LcghashMeasure(sample),
		fibhash.FibhashMeasure(sample),
		pearson.PearsonMeasure(sample),
	}
}
