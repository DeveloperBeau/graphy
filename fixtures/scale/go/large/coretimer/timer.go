package coretimer

import "time"

// Time runs fn once and reports both its result and how long it took.
func Time(fn func() uint64) (uint64, time.Duration) {
	start := time.Now()
	result := fn()
	return result, time.Since(start)
}
