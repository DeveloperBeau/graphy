package registry

import (
	"example.com/hashbench/entry"
	"example.com/hashbench/siphashlite"
	"example.com/hashbench/cityhashlite"
	"example.com/hashbench/xxhashlite"
	"example.com/hashbench/md5lite"
	"example.com/hashbench/shalite"
	"example.com/hashbench/jenkinsoat"
	"example.com/hashbench/bitpair"
)

// VerifyExoticGroup runs the self-check for every family in the exotic group.
func VerifyExoticGroup() []bool {
	return []bool{
		siphashlite.SiphashliteVerify(),
		cityhashlite.CityhashliteVerify(),
		xxhashlite.XxhashliteVerify(),
		md5lite.Md5liteVerify(),
		shalite.ShaliteVerify(),
		jenkinsoat.JenkinsoatVerify(),
		bitpair.BitpairVerify(),
	}
}

// MeasureExoticGroup benchmarks every family in the exotic group.
func MeasureExoticGroup(sample []byte) []entry.Entry {
	return []entry.Entry{
		siphashlite.SiphashliteMeasure(sample),
		cityhashlite.CityhashliteMeasure(sample),
		xxhashlite.XxhashliteMeasure(sample),
		md5lite.Md5liteMeasure(sample),
		shalite.ShaliteMeasure(sample),
		jenkinsoat.JenkinsoatMeasure(sample),
		bitpair.BitpairMeasure(sample),
	}
}
