package source

// Source names one log-emitting service.
type Source struct {
	Name string
}

// Registry tracks every source tag seen so far.
type Registry struct {
	seen map[string]bool
}

// NewRegistry builds an empty source registry.
func NewRegistry() *Registry {
	return &Registry{seen: make(map[string]bool)}
}

// Record adds a tag to the registry.
func (r *Registry) Record(tag string) {
	if tag != "" {
		r.seen[tag] = true
	}
}

// Names returns every distinct source tag seen.
func (r *Registry) Names() []string {
	names := make([]string, 0, len(r.seen))
	for name := range r.seen {
		names = append(names, name)
	}
	return names
}
