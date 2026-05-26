// feature: struct, interface definitions (types)
package graphy

// Greeter is the interface that wraps the Hi method.
type Greeter interface {
	Hi() string
}

// State tracks service lifecycle.
type State struct {
	Name    string
	Running bool
}
