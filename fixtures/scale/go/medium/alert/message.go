package alert

import "fmt"

// Format renders one alert as a human-readable line.
func Format(a Alert) string {
	return fmt.Sprintf("ALERT level=%v count=%d threshold=%d", a.Rule.Level, a.Count, a.Rule.Threshold)
}
