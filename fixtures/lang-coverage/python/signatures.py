class Svc:
    w: Widget
    count: int

    def do(self, x: Widget, n: int) -> Widget:
        return x


def build(w: Widget, n: int, untyped) -> Widget:
    return w


def order(n: int, w: Widget) -> Widget:
    return w


def generic(items: List[Widget], pair: Pair[Foo, Bar]) -> Widget:
    return items[0]
