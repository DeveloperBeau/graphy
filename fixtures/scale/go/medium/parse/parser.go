package parse

import "example.com/logstat/logline"

// ParseLine turns one raw line into an Entry; ok is false for blanks.
func ParseLine(line string) (logline.Entry, bool) {
	ts, level, message, ok := splitFields(line)
	if !ok {
		return logline.Entry{}, false
	}
	return logline.Entry{
		Timestamp: ts,
		Level:     logline.ParseLevel(level),
		Message:   message,
	}, true
}

// ParseAll parses every non-blank line, skipping malformed ones.
func ParseAll(lines []string) []logline.Entry {
	var entries []logline.Entry
	for _, line := range lines {
		if entry, ok := ParseLine(line); ok {
			entries = append(entries, entry)
		}
	}
	return entries
}
