package cli

import (
	"fmt"

	"example.com/shortlink/shortener"
)

// Seed shortens a fixed batch of demo links and expands each once.
func Seed(svc *shortener.Service) {
	targets := []string{"https://example.com/a", "https://example.com/b"}
	for _, target := range targets {
		code, err := svc.Shorten(target)
		if err != nil {
			fmt.Println("skip:", err)
			continue
		}
		full, err := svc.Expand(code)
		if err != nil {
			fmt.Println("skip:", err)
			continue
		}
		fmt.Printf("%s -> %s\n", full, code)
	}
}
