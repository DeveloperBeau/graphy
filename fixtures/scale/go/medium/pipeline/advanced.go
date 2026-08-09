package pipeline

import (
	"example.com/logstat/alert"
	"example.com/logstat/dedupe"
	"example.com/logstat/exporter"
	"example.com/logstat/filter"
	"example.com/logstat/logline"
	"example.com/logstat/parse"
	"example.com/logstat/report"
	"example.com/logstat/stats"
)

// RunAdvanced parses, dedupes, filters, tallies, and assembles a
// multi-section report including any fired alerts.
func RunAdvanced(lines []string, minLevel string) string {
	entries := dedupe.Collapse(parse.ParseAll(lines))
	kept := filter.AboveLevel(entries, logline.ParseLevel(minLevel))
	counts := stats.Tally(kept)
	summary := stats.Summarize(counts)

	w := &exporter.Writer{}
	w.Add(report.Render(counts, summary))
	w.Add(report.AlertSection(alert.Evaluate(counts, alert.DefaultRules())))
	return w.String()
}
