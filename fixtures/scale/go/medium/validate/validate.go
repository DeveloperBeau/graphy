package validate

import "strings"

// Line rejects raw lines that cannot plausibly be a log entry: at
// least a timestamp, a level, and a message separated by spaces.
func Line(raw string) bool {
	return len(strings.Fields(raw)) >= 3
}
