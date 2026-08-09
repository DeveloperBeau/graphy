package registry

import "example.com/hashbench/entry"

// VerifyAll runs the self-check for every registered hash family.
func VerifyAll() []bool {
	var out []bool
	out = append(out, VerifyBytemixGroup()...)
	out = append(out, VerifyChecksumGroup()...)
	out = append(out, VerifyRollingGroup()...)
	out = append(out, VerifyMixersGroup()...)
	out = append(out, VerifyClassicGroup()...)
	out = append(out, VerifyExoticGroup()...)
	return out
}

// MeasureAll benchmarks every registered hash family against sample.
func MeasureAll(sample []byte) []entry.Entry {
	var out []entry.Entry
	out = append(out, MeasureBytemixGroup(sample)...)
	out = append(out, MeasureChecksumGroup(sample)...)
	out = append(out, MeasureRollingGroup(sample)...)
	out = append(out, MeasureMixersGroup(sample)...)
	out = append(out, MeasureClassicGroup(sample)...)
	out = append(out, MeasureExoticGroup(sample)...)
	return out
}
