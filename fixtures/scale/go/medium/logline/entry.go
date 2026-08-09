package logline

// Entry is one parsed log line.
type Entry struct {
	Timestamp string
	Level     Level
	Message   string
}

// AtLeast reports whether the entry meets a minimum severity.
func (e Entry) AtLeast(min Level) bool {
	return e.Level >= min
}
