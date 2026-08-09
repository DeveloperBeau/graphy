package config

// Config holds the tunables threaded through the pipeline.
type Config struct {
	MinLevel     string
	WindowDigits int
	Format       string
}

// Default returns the standard configuration.
func Default() Config {
	return Config{MinLevel: "INFO", WindowDigits: 13, Format: "table"}
}
