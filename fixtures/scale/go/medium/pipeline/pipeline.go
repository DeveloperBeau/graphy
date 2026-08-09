package pipeline

import (
	"example.com/logstat/filter"
	"example.com/logstat/logline"
	"example.com/logstat/parse"
	"example.com/logstat/report"
	"example.com/logstat/stats"
)

// Run parses raw lines, filters by minimum level, tallies, and
// renders the whole report in one call.
func Run(lines []string, minLevel string) string {
	entries := parse.ParseAll(lines)
	kept := filter.AboveLevel(entries, logline.ParseLevel(minLevel))
	counts := stats.Tally(kept)
	summary := stats.Summarize(counts)
	return report.Render(counts, summary)
}
