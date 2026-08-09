package redact

import "regexp"

var tokenPattern = regexp.MustCompile(`token=\S+`)

// Message masks bearer-token-like substrings before display.
func Message(message string) string {
	return tokenPattern.ReplaceAllString(message, "token=***")
}
