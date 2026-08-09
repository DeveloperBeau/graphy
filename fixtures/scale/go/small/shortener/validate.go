package shortener

import (
	"errors"
	"strings"
)

// ErrBadURL is returned when a target fails validation.
var ErrBadURL = errors.New("target must start with http:// or https://")

// ValidateURL rejects targets that are not absolute http(s) URLs.
func ValidateURL(target string) error {
	if !strings.HasPrefix(target, "http://") && !strings.HasPrefix(target, "https://") {
		return ErrBadURL
	}
	return nil
}
