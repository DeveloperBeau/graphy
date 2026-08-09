package exporter

import "strings"

// Writer accumulates report sections and joins them with blank lines.
type Writer struct {
	sections []string
}

// Add appends a rendered section.
func (w *Writer) Add(section string) {
	w.sections = append(w.sections, section)
}

// String joins every section into the final report.
func (w *Writer) String() string {
	return strings.Join(w.sections, "\n\n")
}
