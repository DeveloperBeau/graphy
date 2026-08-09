package severity

import "example.com/logstat/logline"

// Weight assigns a numeric ranking used to sort or score entries.
func Weight(level logline.Level) int {
	switch level {
	case logline.Error:
		return 30
	case logline.Warn:
		return 20
	case logline.Info:
		return 10
	default:
		return 0
	}
}
