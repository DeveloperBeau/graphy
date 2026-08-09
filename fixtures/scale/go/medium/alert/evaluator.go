package alert

import "example.com/logstat/stats"

// Alert is one triggered rule.
type Alert struct {
	Rule  Rule
	Count int
}

// Evaluate checks every rule against the observed counts.
func Evaluate(counts stats.Counts, rules []Rule) []Alert {
	var fired []Alert
	for _, rule := range rules {
		count := counts.Get(rule.Level)
		if count >= rule.Threshold {
			fired = append(fired, Alert{Rule: rule, Count: count})
		}
	}
	return fired
}
