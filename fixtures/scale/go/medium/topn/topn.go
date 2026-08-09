package topn

import (
	"sort"

	"example.com/logstat/logline"
)

// Row is one distinct message and how often it occurred.
type Row struct {
	Message string
	Count   int
}

// Top returns the n most frequent messages, most frequent first.
func Top(entries []logline.Entry, n int) []Row {
	counts := make(map[string]int)
	for _, entry := range entries {
		counts[entry.Message]++
	}
	rows := make([]Row, 0, len(counts))
	for message, count := range counts {
		rows = append(rows, Row{Message: message, Count: count})
	}
	sort.Slice(rows, func(i, j int) bool { return rows[i].Count > rows[j].Count })
	if len(rows) > n {
		rows = rows[:n]
	}
	return rows
}
