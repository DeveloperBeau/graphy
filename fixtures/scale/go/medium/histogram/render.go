package histogram

import (
	"fmt"
	"strings"
)

// Render renders each row as "key: n" using the row's total count.
func Render(rows []Row) string {
	lines := make([]string, 0, len(rows))
	for _, row := range rows {
		total := 0
		for _, count := range row.Counts {
			total += count
		}
		lines = append(lines, fmt.Sprintf("%s: %d", row.Key, total))
	}
	return strings.Join(lines, "\n")
}
