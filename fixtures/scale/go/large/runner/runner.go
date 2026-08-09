package runner

import (
	"example.com/hashbench/coresample"
	"example.com/hashbench/corestats"
	"example.com/hashbench/entry"
	"example.com/hashbench/registry"
)

// Report summarizes a full benchmark pass across every hash family.
type Report struct {
	Entries []entry.Entry
	Summary string
	AllOK   bool
}

// RunnerRun verifies every family, benchmarks it against the shared corpus,
// and returns a combined report.
func RunnerRun() Report {
	sample := coresample.BuildCorpus()
	checks := registry.VerifyAll()
	entries := registry.MeasureAll(sample)

	ok := true
	for _, c := range checks {
		if !c {
			ok = false
		}
	}

	return Report{
		Entries: entries,
		Summary: corestats.FormatSummary(entries),
		AllOK:   ok,
	}
}
