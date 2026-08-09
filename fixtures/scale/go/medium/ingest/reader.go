package ingest

import "strings"

// ReadSource splits a raw multi-line blob into individual lines.
func ReadSource(raw string) []string {
	var lines []string
	for _, line := range strings.Split(raw, "\n") {
		if strings.TrimSpace(line) != "" {
			lines = append(lines, line)
		}
	}
	return lines
}
