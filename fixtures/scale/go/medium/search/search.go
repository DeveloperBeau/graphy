package search

import (
	"strings"

	"example.com/logstat/logline"
)

// Contains returns entries whose message includes term, case-insensitively.
func Contains(entries []logline.Entry, term string) []logline.Entry {
	needle := strings.ToLower(term)
	var hits []logline.Entry
	for _, entry := range entries {
		if strings.Contains(strings.ToLower(entry.Message), needle) {
			hits = append(hits, entry)
		}
	}
	return hits
}
