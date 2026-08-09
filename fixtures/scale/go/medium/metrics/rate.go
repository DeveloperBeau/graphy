package metrics

import "example.com/logstat/stats"

// ErrorRate returns the fraction of total entries that were errors.
func ErrorRate(summary stats.Summary) float64 {
	if summary.Total == 0 {
		return 0
	}
	return float64(summary.Errors) / float64(summary.Total)
}
