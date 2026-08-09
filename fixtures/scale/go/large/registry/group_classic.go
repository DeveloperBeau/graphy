package registry

import (
	"example.com/hashbench/entry"
	"example.com/hashbench/elfhash"
	"example.com/hashbench/pjwhash"
	"example.com/hashbench/aphash"
	"example.com/hashbench/jshash"
	"example.com/hashbench/rshash"
	"example.com/hashbench/loselose"
	"example.com/hashbench/oatvariant"
	"example.com/hashbench/rot13sum"
)

// VerifyClassicGroup runs the self-check for every family in the classic group.
func VerifyClassicGroup() []bool {
	return []bool{
		elfhash.ElfhashVerify(),
		pjwhash.PjwhashVerify(),
		aphash.AphashVerify(),
		jshash.JshashVerify(),
		rshash.RshashVerify(),
		loselose.LoseloseVerify(),
		oatvariant.OatvariantVerify(),
		rot13sum.Rot13sumVerify(),
	}
}

// MeasureClassicGroup benchmarks every family in the classic group.
func MeasureClassicGroup(sample []byte) []entry.Entry {
	return []entry.Entry{
		elfhash.ElfhashMeasure(sample),
		pjwhash.PjwhashMeasure(sample),
		aphash.AphashMeasure(sample),
		jshash.JshashMeasure(sample),
		rshash.RshashMeasure(sample),
		loselose.LoseloseMeasure(sample),
		oatvariant.OatvariantMeasure(sample),
		rot13sum.Rot13sumMeasure(sample),
	}
}
