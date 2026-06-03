package signatures

type Widget struct {
	Label string
	Inner *Widget
}

type Svc struct {
	W Widget
}

func Build(w Widget, n int) Widget {
	return w
}

func Order(n int, w Widget) Widget {
	return w
}

func (s Svc) Do(x Widget) Widget {
	return x
}

func Pair() (Widget, error) {
	return Widget{}, nil
}

type Multi struct {
	A, B Widget
}

// Generic instantiation: Box[Widget] should emit edges to both the
// container base Box and the inner Widget; the bare w stays one edge.
func Wrap(b Box[Widget], w Widget) Widget {
	return w
}
