package cli

import (
	"fmt"

	"example.com/shortlink/shortener"
)

// Report prints the service's link and click totals.
func Report(svc *shortener.Service) {
	stats := svc.Snapshot()
	fmt.Printf("links=%d clicks=%d\n", stats.LinkCount, stats.TotalClicks)
}
