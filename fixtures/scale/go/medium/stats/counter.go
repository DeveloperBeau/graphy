package stats

import "example.com/logstat/logline"

// Counts tallies how many entries fall in each level.
type Counts struct {
	byLevel map[logline.Level]int
}

// Tally counts the entries by level.
func Tally(entries []logline.Entry) Counts {
	counts := Counts{byLevel: make(map[logline.Level]int)}
	for _, entry := range entries {
		counts.byLevel[entry.Level]++
	}
	return counts
}

// Get returns the count for a level.
func (c Counts) Get(level logline.Level) int {
	return c.byLevel[level]
}
