package dedupe

import "example.com/logstat/logline"

// Collapse drops consecutive entries that share the same message,
// keeping only the first occurrence of each run.
func Collapse(entries []logline.Entry) []logline.Entry {
	out := make([]logline.Entry, 0, len(entries))
	var last string
	for i, entry := range entries {
		if i > 0 && entry.Message == last {
			continue
		}
		out = append(out, entry)
		last = entry.Message
	}
	return out
}
