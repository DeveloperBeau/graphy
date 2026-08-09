package stats

import "example.com/logstat/logline"

// Fraction returns a level's share of the total as a percentage.
func (c Counts) Fraction(level logline.Level, total int) float64 {
	if total == 0 {
		return 0
	}
	return float64(c.Get(level)) / float64(total) * 100
}
