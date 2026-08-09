package ingest

// Batch combines several named raw sources into one ordered line list.
func Batch(sources map[string]string, order []string) []string {
	var all []string
	for _, name := range order {
		all = append(all, ReadSource(sources[name])...)
	}
	return all
}
