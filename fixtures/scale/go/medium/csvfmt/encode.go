package csvfmt

import (
	"fmt"
	"strings"

	"example.com/logstat/logline"
)

// Encode renders entries as CSV with a header row.
func Encode(entries []logline.Entry) string {
	rows := []string{"timestamp,level,message"}
	for _, entry := range entries {
		rows = append(rows, fmt.Sprintf("%s,%s,%s", entry.Timestamp, entry.Level.String(), entry.Message))
	}
	return strings.Join(rows, "\n")
}
