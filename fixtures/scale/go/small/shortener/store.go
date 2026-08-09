package shortener

// store is an in-memory code -> target map.
type store struct {
	entries map[string]string
}

func newStore() *store {
	return &store{entries: make(map[string]string)}
}

func (s *store) put(code, target string) {
	s.entries[code] = target
}

func (s *store) get(code string) (string, bool) {
	target, ok := s.entries[code]
	return target, ok
}
