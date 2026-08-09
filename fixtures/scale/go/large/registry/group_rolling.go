package registry

import (
	"example.com/hashbench/entry"
	"example.com/hashbench/rollingadd"
	"example.com/hashbench/rollingmul"
	"example.com/hashbench/rollingpoly"
	"example.com/hashbench/cyclicpoly"
	"example.com/hashbench/sdbm"
	"example.com/hashbench/bkdr"
	"example.com/hashbench/sdslhash"
)

// VerifyRollingGroup runs the self-check for every family in the rolling group.
func VerifyRollingGroup() []bool {
	return []bool{
		rollingadd.RollingaddVerify(),
		rollingmul.RollingmulVerify(),
		rollingpoly.RollingpolyVerify(),
		cyclicpoly.CyclicpolyVerify(),
		sdbm.SdbmVerify(),
		bkdr.BkdrVerify(),
		sdslhash.SdslhashVerify(),
	}
}

// MeasureRollingGroup benchmarks every family in the rolling group.
func MeasureRollingGroup(sample []byte) []entry.Entry {
	return []entry.Entry{
		rollingadd.RollingaddMeasure(sample),
		rollingmul.RollingmulMeasure(sample),
		rollingpoly.RollingpolyMeasure(sample),
		cyclicpoly.CyclicpolyMeasure(sample),
		sdbm.SdbmMeasure(sample),
		bkdr.BkdrMeasure(sample),
		sdslhash.SdslhashMeasure(sample),
	}
}
