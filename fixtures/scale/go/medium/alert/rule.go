package alert

import "example.com/logstat/logline"

// Rule fires when a level's count meets or exceeds Threshold.
type Rule struct {
	Level     logline.Level
	Threshold int
}

// DefaultRules returns the standard alerting thresholds.
func DefaultRules() []Rule {
	return []Rule{
		{Level: logline.Error, Threshold: 1},
		{Level: logline.Warn, Threshold: 3},
	}
}
