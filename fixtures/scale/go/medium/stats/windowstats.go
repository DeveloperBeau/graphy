package stats

import "example.com/logstat/window"

// TallyWindows counts every level within each window bucket.
func TallyWindows(buckets []window.Bucket) []Counts {
	out := make([]Counts, 0, len(buckets))
	for _, bucket := range buckets {
		out = append(out, Tally(bucket.Entries))
	}
	return out
}
