package parse

import "strings"

// splitFields breaks a raw line into timestamp, level, and message,
// tolerating extra spaces in the message body.
func splitFields(line string) (string, string, string, bool) {
	parts := strings.SplitN(strings.TrimSpace(line), " ", 3)
	if len(parts) < 3 {
		return "", "", "", false
	}
	return parts[0], parts[1], parts[2], true
}
