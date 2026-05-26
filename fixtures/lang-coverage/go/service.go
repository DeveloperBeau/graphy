// feature: struct method, grouped import, aliased import, cross-file call,
//          external call (fmt.Println must not produce local edge).
package graphy

import (
	"fmt"
	f "fmt"
	_ "os"
)

// Service satisfies Greeter structurally.
type Service struct {
	name string
}

// NewService constructs a Service.
func NewService(name string) *Service {
	return &Service{name: name}
}

// Hi implements the Greeter interface.
func (s *Service) Hi() string {
	return "hello from " + s.name
}

// Run executes the service logic.
func (s *Service) Run() {
	greeting := FormatName(s.name)
	fmt.Println(greeting)
	f.Println("done")
}
