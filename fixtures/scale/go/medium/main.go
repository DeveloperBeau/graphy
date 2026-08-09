package main

import (
	"fmt"
	"strings"

	"example.com/logstat/cli"
	"example.com/logstat/pipeline"
)

const sample = `[api] 2024-01-01T10:00:00 INFO started
[api] 2024-01-01T10:00:01 WARN slow response
[db] 2024-01-01T10:00:02 ERROR upstream failed`

func main() {
	lines := strings.Split(sample, "\n")
	fmt.Println(pipeline.Run(lines, "INFO"))
	fmt.Println(pipeline.RunAdvanced(lines, "INFO"))

	sources := map[string]string{"primary": sample}
	batched := pipeline.RunMultiSource(sources, []string{"primary"})
	fmt.Printf("batched=%d\n", len(batched))

	cli.Run(lines, []string{"format=json"})
	fmt.Println(pipeline.RunAnalytics(lines, "slow"))
}
