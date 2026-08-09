package report

import (
	"fmt"
	"strings"

	"example.com/logstat/stats"
)

// Render builds the final textual report from counts and summary.
func Render(counts stats.Counts, summary stats.Summary) string {
	var b strings.Builder
	b.WriteString("log report\n")
	b.WriteString(strings.Join(levelRows(counts), "\n"))
	b.WriteString(fmt.Sprintf("\ntotal=%d errors=%d", summary.Total, summary.Errors))
	return b.String()
}
