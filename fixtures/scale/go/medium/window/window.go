package window

import "example.com/logstat/logline"

// GroupByWindow buckets entries by the first n characters of their
// timestamp, which for ISO-8601 input approximates a time window.
func GroupByWindow(entries []logline.Entry, prefixLen int) []Bucket {
	order := make([]string, 0)
	byKey := make(map[string][]logline.Entry)
	for _, entry := range entries {
		key := entry.Timestamp
		if len(key) > prefixLen {
			key = key[:prefixLen]
		}
		if _, ok := byKey[key]; !ok {
			order = append(order, key)
		}
		byKey[key] = append(byKey[key], entry)
	}
	buckets := make([]Bucket, 0, len(order))
	for _, key := range order {
		buckets = append(buckets, Bucket{Key: key, Entries: byKey[key]})
	}
	return buckets
}
