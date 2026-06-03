// Typed-layer coverage fixture.

struct Widget {
    var label: String
    var next: Widget?
}

class Factory {
    var item: Widget

    func process(count: Int, widget: Widget) -> Widget {
        return widget
    }
}

func build(w: Widget, n: Int) -> Widget {
    return w
}

func order(n: Int, w: Widget) -> Widget {
    return w
}
