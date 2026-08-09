package shortener

import (
	"errors"
	"time"
)

// ErrExpired is returned when a code's deadline has passed.
var ErrExpired = errors.New("short code has expired")

// expiryTracker records when each code should stop resolving.
type expiryTracker struct {
	deadlines map[string]time.Time
}

func newExpiryTracker() *expiryTracker {
	return &expiryTracker{deadlines: make(map[string]time.Time)}
}

func (e *expiryTracker) setTTL(code string, ttl time.Duration) {
	e.deadlines[code] = time.Now().Add(ttl)
}

// expired reports whether code has passed its deadline; codes with no
// recorded deadline never expire.
func (e *expiryTracker) expired(code string) bool {
	deadline, ok := e.deadlines[code]
	return ok && time.Now().After(deadline)
}
