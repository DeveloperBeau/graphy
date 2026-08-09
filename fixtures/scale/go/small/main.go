package main

import (
	"example.com/shortlink/cli"
	"example.com/shortlink/shortener"
)

func main() {
	svc := shortener.New("https://sho.rt/")
	cli.Seed(svc)
	cli.Report(svc)
}
