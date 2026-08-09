package jsonfmt

import (
	"fmt"
	"strings"

	"example.com/logstat/logline"
)

// Encode renders entries as a minimal JSON array of objects.
func Encode(entries []logline.Entry) string {
	rows := make([]string, 0, len(entries))
	for _, entry := range entries {
		rows = append(rows, fmt.Sprintf(
			`{"ts":%q,"level":%q,"msg":%q}`, entry.Timestamp, entry.Level.String(), entry.Message))
	}
	return "[" + strings.Join(rows, ",") + "]"
}
