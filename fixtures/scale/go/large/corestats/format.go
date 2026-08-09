package corestats

import (
	"fmt"

	"example.com/hashbench/entry"
)

// FormatSummary renders a compact multi-line summary of every entry.
func FormatSummary(entries []entry.Entry) string {
	out := fmt.Sprintf("%d entries measured\n", len(entries))
	for _, e := range entries {
		out += entry.FormatEntry(e) + "\n"
	}
	return out
}
