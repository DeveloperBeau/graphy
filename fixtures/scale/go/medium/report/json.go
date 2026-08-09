package report

import (
	"example.com/logstat/jsonfmt"
	"example.com/logstat/logline"
)

// AsJSON renders the entries section of the report as JSON.
func AsJSON(entries []logline.Entry) string {
	return jsonfmt.Encode(entries)
}
