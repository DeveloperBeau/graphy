package filter

import "example.com/logstat/logline"

// AboveLevel keeps only entries at or above the minimum severity.
func AboveLevel(entries []logline.Entry, min logline.Level) []logline.Entry {
	kept := make([]logline.Entry, 0, len(entries))
	for _, entry := range entries {
		if entry.AtLeast(min) {
			kept = append(kept, entry)
		}
	}
	return kept
}
