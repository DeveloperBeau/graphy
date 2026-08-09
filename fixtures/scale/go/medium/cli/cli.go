package cli

import (
	"fmt"

	"example.com/logstat/config"
	"example.com/logstat/parse"
	"example.com/logstat/pipeline"
)

// Run wires flag parsing to the advanced pipeline, prints the report,
// then re-renders the parsed entries in the configured output format.
func Run(lines []string, args []string) {
	cfg := config.ParseFlags(config.Default(), args)
	fmt.Println(pipeline.RunAdvanced(lines, cfg.MinLevel))
	WriteOutput(cfg.Format, parse.ParseAll(lines))
}
