package entry

import "fmt"

// FormatEntry renders a single Entry as one report line.
func FormatEntry(e Entry) string {
	return fmt.Sprintf("%-16s digest=%#x bytes=%d elapsed=%s", e.Name, e.Digest, e.Bytes, e.Elapsed)
}
