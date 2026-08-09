package window

import "example.com/logstat/logline"

// Bucket groups entries that share a timestamp prefix.
type Bucket struct {
	Key     string
	Entries []logline.Entry
}
