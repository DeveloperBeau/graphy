// feature: top-level function, called cross-file
package graphy

import "strings"

// FormatName returns a greeting string for the given name.
func FormatName(name string) string {
	return "hi, " + strings.TrimSpace(name)
}

// UnrelatedHelper returns a fixed integer.
func UnrelatedHelper() int {
	return 7
}
