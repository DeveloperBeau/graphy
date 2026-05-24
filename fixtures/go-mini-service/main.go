package main

import (
	"fmt"

	"example.com/mini/server"
)

func main() {
	s := server.New()
	s.Serve()
	fmt.Println("done")
}
