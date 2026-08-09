package corestats

import "math"

// Mean returns the arithmetic mean of values, or 0 for an empty slice.
func Mean(values []float64) float64 {
	if len(values) == 0 {
		return 0
	}
	var sum float64
	for _, v := range values {
		sum += v
	}
	return sum / float64(len(values))
}

// StdDev returns the population standard deviation of values.
func StdDev(values []float64) float64 {
	if len(values) == 0 {
		return 0
	}
	m := Mean(values)
	var sum float64
	for _, v := range values {
		d := v - m
		sum += d * d
	}
	return math.Sqrt(sum / float64(len(values)))
}
