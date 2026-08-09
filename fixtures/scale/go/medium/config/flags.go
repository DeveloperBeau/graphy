package config

import "strings"

// ParseFlags applies simple "key=value" overrides onto a base config.
func ParseFlags(base Config, args []string) Config {
	cfg := base
	for _, arg := range args {
		key, value, ok := strings.Cut(arg, "=")
		if !ok {
			continue
		}
		switch key {
		case "level":
			cfg.MinLevel = value
		case "format":
			cfg.Format = value
		}
	}
	return cfg
}
