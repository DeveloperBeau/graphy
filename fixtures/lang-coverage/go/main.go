// feature: main entry point
package graphy

// Entry is the program entry point.
func Entry() {
	svc := NewService("world")
	svc.Run()
}
