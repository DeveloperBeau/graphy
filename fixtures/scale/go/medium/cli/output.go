package cli

import (
	"fmt"

	"example.com/logstat/csvfmt"
	"example.com/logstat/jsonfmt"
	"example.com/logstat/logline"
)

// WriteOutput prints entries in the requested format, defaulting to
// a plain count when the format is unrecognized.
func WriteOutput(format string, entries []logline.Entry) {
	switch format {
	case "json":
		fmt.Println(jsonfmt.Encode(entries))
	case "csv":
		fmt.Println(csvfmt.Encode(entries))
	default:
		fmt.Printf("entries=%d\n", len(entries))
	}
}
