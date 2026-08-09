package report

import (
	"example.com/logstat/csvfmt"
	"example.com/logstat/logline"
)

// AsCSV renders the entries section of the report as CSV.
func AsCSV(entries []logline.Entry) string {
	return csvfmt.Encode(entries)
}
