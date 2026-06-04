package signatures

data class Widget(val label: String, val owner: Widget?)

class Repo {
    val store: Widget = Widget("", null)

    fun process(count: Int, widget: Widget): Widget {
        return widget
    }
}

fun build(widget: Widget, n: Int): Widget {
    return widget
}

fun order(n: Int, widget: Widget): Widget {
    return widget
}

data class Foo(val a: Int)

data class Bar(val b: Int)

fun generic(items: List<Widget>, pair: Pair<Foo, Bar>) {
    return
}
