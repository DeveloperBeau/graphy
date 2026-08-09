package registry

import (
	"example.com/hashbench/entry"
	"example.com/hashbench/adler32lite"
	"example.com/hashbench/crc32lite"
	"example.com/hashbench/crc16lite"
	"example.com/hashbench/checksum8"
	"example.com/hashbench/checksumxor"
	"example.com/hashbench/fletcher16"
	"example.com/hashbench/fletcher32"
	"example.com/hashbench/fletcher64"
)

// VerifyChecksumGroup runs the self-check for every family in the checksum group.
func VerifyChecksumGroup() []bool {
	return []bool{
		adler32lite.Adler32liteVerify(),
		crc32lite.Crc32liteVerify(),
		crc16lite.Crc16liteVerify(),
		checksum8.Checksum8Verify(),
		checksumxor.ChecksumxorVerify(),
		fletcher16.Fletcher16Verify(),
		fletcher32.Fletcher32Verify(),
		fletcher64.Fletcher64Verify(),
	}
}

// MeasureChecksumGroup benchmarks every family in the checksum group.
func MeasureChecksumGroup(sample []byte) []entry.Entry {
	return []entry.Entry{
		adler32lite.Adler32liteMeasure(sample),
		crc32lite.Crc32liteMeasure(sample),
		crc16lite.Crc16liteMeasure(sample),
		checksum8.Checksum8Measure(sample),
		checksumxor.ChecksumxorMeasure(sample),
		fletcher16.Fletcher16Measure(sample),
		fletcher32.Fletcher32Measure(sample),
		fletcher64.Fletcher64Measure(sample),
	}
}
