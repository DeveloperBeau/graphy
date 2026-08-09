package trend

// Deltas returns the change in total between consecutive points.
func Deltas(points []Point) []int {
	deltas := make([]int, 0, len(points))
	for i := 1; i < len(points); i++ {
		deltas = append(deltas, points[i].Total-points[i-1].Total)
	}
	return deltas
}
