package shortener

import "time"

// Service issues short codes for URLs and expands them back.
type Service struct {
	prefix string
	store  *store
	clicks *clickCounter
	expiry *expiryTracker
	seq    uint64
}

// New builds a Service that renders codes under the given prefix.
func New(prefix string) *Service {
	return &Service{
		prefix: prefix,
		store:  newStore(),
		clicks: newClickCounter(),
		expiry: newExpiryTracker(),
	}
}

// Shorten validates target, mints a new code, and registers it.
func (s *Service) Shorten(target string) (string, error) {
	if err := ValidateURL(target); err != nil {
		return "", err
	}
	s.seq++
	code := encode(s.seq)
	s.store.put(code, target)
	return code, nil
}

// ShortenWithAlias registers target under a caller-chosen alias.
func (s *Service) ShortenWithAlias(target, alias string) error {
	if err := ValidateURL(target); err != nil {
		return err
	}
	if err := ValidateAlias(alias); err != nil {
		return err
	}
	s.store.put(alias, target)
	return nil
}

// Expire marks a code as invalid after ttl elapses.
func (s *Service) Expire(code string, ttl time.Duration) {
	s.expiry.setTTL(code, ttl)
}

// Expand records a click and returns the full short URL for a code,
// or ErrExpired if the code's deadline has passed.
func (s *Service) Expand(code string) (string, error) {
	if s.expiry.expired(code) {
		return "", ErrExpired
	}
	s.clicks.record(code)
	return s.prefix + code, nil
}

// Clicks returns how many times a code has been expanded.
func (s *Service) Clicks(code string) int {
	return s.clicks.total(code)
}
