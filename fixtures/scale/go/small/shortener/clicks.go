package shortener

// clickCounter tallies visits per short code.
type clickCounter struct {
	counts map[string]int
}

func newClickCounter() *clickCounter {
	return &clickCounter{counts: make(map[string]int)}
}

func (c *clickCounter) record(code string) {
	c.counts[code]++
}

func (c *clickCounter) total(code string) int {
	return c.counts[code]
}
