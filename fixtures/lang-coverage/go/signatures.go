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
