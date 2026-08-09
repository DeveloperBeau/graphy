package pipeline

import (
	"fmt"
	"strings"

	"example.com/logstat/dedupe"
	"example.com/logstat/histogram"
	"example.com/logstat/metrics"
	"example.com/logstat/parse"
	"example.com/logstat/redact"
	"example.com/logstat/search"
	"example.com/logstat/severity"
	"example.com/logstat/stats"
	"example.com/logstat/tagindex"
	"example.com/logstat/topn"
	"example.com/logstat/trend"
	"example.com/logstat/window"
)

// RunAnalytics exercises the full analytics surface: windowed
// histograms, trend deltas, top messages, source grouping, search,
// severity weighting, redaction, and the overall error rate.
func RunAnalytics(lines []string, term string) string {
	entries := dedupe.Collapse(parse.ParseAll(lines))
	buckets := window.GroupByWindow(entries, 13)
	rows := histogram.Build(buckets)
	deltas := trend.Deltas(trend.FromHistogram(rows))

	summary := stats.Summarize(stats.Tally(entries))
	rate := metrics.ErrorRate(summary)

	top := topn.Top(entries, 3)
	bySource := tagindex.BySource(entries)
	hits := search.Contains(entries, term)

	var b strings.Builder
	b.WriteString(histogram.Render(rows))
	b.WriteString(fmt.Sprintf("\ndeltas=%d rate=%.2f top=%d sources=%d hits=%d",
		len(deltas), rate, len(top), len(bySource), len(hits)))
	if len(entries) > 0 {
		b.WriteString(fmt.Sprintf("\nweight=%d sample=%s",
			severity.Weight(entries[0].Level), redact.Message(entries[0].Message)))
	}
	return b.String()
}
