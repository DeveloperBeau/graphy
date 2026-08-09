package source

import "strings"

// ExtractTag pulls a leading "[service]" tag off a message, if present.
func ExtractTag(message string) (string, string) {
	if !strings.HasPrefix(message, "[") {
		return "", message
	}
	end := strings.Index(message, "]")
	if end < 0 {
		return "", message
	}
	return message[1:end], strings.TrimSpace(message[end+1:])
}
