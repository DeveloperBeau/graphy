package report

import (
	"strings"

	"example.com/logstat/alert"
)

// AlertSection renders every fired alert as its own line.
func AlertSection(alerts []alert.Alert) string {
	if len(alerts) == 0 {
		return "no alerts"
	}
	lines := make([]string, 0, len(alerts))
	for _, a := range alerts {
		lines = append(lines, alert.Format(a))
	}
	return strings.Join(lines, "\n")
}
