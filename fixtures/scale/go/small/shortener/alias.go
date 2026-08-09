package shortener

import (
	"errors"
	"regexp"
)

var aliasPattern = regexp.MustCompile(`^[a-zA-Z0-9_-]{3,20}$`)

// ErrBadAlias is returned when a requested custom alias is malformed.
var ErrBadAlias = errors.New("alias must be 3-20 alphanumeric characters")

// ValidateAlias rejects aliases that do not match the allowed pattern.
func ValidateAlias(alias string) error {
	if !aliasPattern.MatchString(alias) {
		return ErrBadAlias
	}
	return nil
}
