package pipeline

import (
	"example.com/logstat/ingest"
	"example.com/logstat/source"
)

// RunMultiSource batches named raw inputs and records their tags.
func RunMultiSource(sources map[string]string, order []string) []string {
	registry := source.NewRegistry()
	for _, name := range order {
		registry.Record(name)
	}
	return ingest.Batch(sources, order)
}
