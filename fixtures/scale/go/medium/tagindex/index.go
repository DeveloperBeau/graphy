package tagindex

import (
	"example.com/logstat/logline"
	"example.com/logstat/source"
)

// BySource groups entries under the source tag extracted from their
// message, falling back to "unknown" when no tag is present.
func BySource(entries []logline.Entry) map[string][]logline.Entry {
	grouped := make(map[string][]logline.Entry)
	for _, entry := range entries {
		tag, _ := source.ExtractTag(entry.Message)
		if tag == "" {
			tag = "unknown"
		}
		grouped[tag] = append(grouped[tag], entry)
	}
	return grouped
}
