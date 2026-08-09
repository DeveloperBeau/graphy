package report

import (
	"fmt"

	"example.com/logstat/logline"
	"example.com/logstat/stats"
)

// levelRows renders one line per level with its count.
func levelRows(counts stats.Counts) []string {
	levels := []logline.Level{logline.Debug, logline.Info, logline.Warn, logline.Error}
	rows := make([]string, 0, len(levels))
	for _, level := range levels {
		rows = append(rows, fmt.Sprintf("  %-5s %d", level.String(), counts.Get(level)))
	}
	return rows
}
