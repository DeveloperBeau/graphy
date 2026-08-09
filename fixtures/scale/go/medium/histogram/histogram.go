package histogram

import (
	"example.com/logstat/logline"
	"example.com/logstat/window"
)

// Row is one window's per-level tally.
type Row struct {
	Key    string
	Counts map[logline.Level]int
}

// Build computes a per-window, per-level histogram.
func Build(buckets []window.Bucket) []Row {
	rows := make([]Row, 0, len(buckets))
	for _, bucket := range buckets {
		counts := make(map[logline.Level]int)
		for _, entry := range bucket.Entries {
			counts[entry.Level]++
		}
		rows = append(rows, Row{Key: bucket.Key, Counts: counts})
	}
	return rows
}
