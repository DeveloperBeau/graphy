package logline

// Level is a syslog-style severity.
type Level int

const (
	Debug Level = iota
	Info
	Warn
	Error
)

// ParseLevel maps a textual level to its enum, defaulting to Info.
func ParseLevel(text string) Level {
	switch text {
	case "DEBUG":
		return Debug
	case "WARN":
		return Warn
	case "ERROR":
		return Error
	default:
		return Info
	}
}

// String renders a level back to its canonical name.
func (l Level) String() string {
	return [...]string{"DEBUG", "INFO", "WARN", "ERROR"}[l]
}
