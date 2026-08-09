package cli

import (
	"fmt"

	"example.com/hashbench/runner"
)

// CliRun executes the full benchmark suite and prints a human-readable
// report to standard output.
func CliRun() {
	report := runner.RunnerRun()
	fmt.Printf("hashbench: %d families measured, all-ok=%v\n", len(report.Entries), report.AllOK)
	fmt.Println(report.Summary)
}
