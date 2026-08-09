package shortener

// Stats is a point-in-time summary of a Service's activity.
type Stats struct {
	LinkCount  int
	TotalClicks int
}

// Snapshot totals every stored link's click count.
func (s *Service) Snapshot() Stats {
	total := 0
	for code := range s.store.entries {
		total += s.Clicks(code)
	}
	return Stats{LinkCount: len(s.store.entries), TotalClicks: total}
}
