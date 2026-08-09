package stats

import "example.com/logstat/logline"

// Summary is the aggregate view rendered in the report.
type Summary struct {
	Total  int
	Errors int
}

// Summarize reduces per-level counts into a Summary.
func Summarize(counts Counts) Summary {
	total := 0
	for _, level := range []logline.Level{logline.Debug, logline.Info, logline.Warn, logline.Error} {
		total += counts.Get(level)
	}
	return Summary{Total: total, Errors: counts.Get(logline.Error)}
}
