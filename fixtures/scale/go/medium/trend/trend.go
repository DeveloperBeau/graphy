package trend

import "example.com/logstat/histogram"

// Point is one window's total count, used for a simple trend line.
type Point struct {
	Key   string
	Total int
}

// FromHistogram reduces histogram rows to total-per-window points.
func FromHistogram(rows []histogram.Row) []Point {
	points := make([]Point, 0, len(rows))
	for _, row := range rows {
		total := 0
		for _, count := range row.Counts {
			total += count
		}
		points = append(points, Point{Key: row.Key, Total: total})
	}
	return points
}
