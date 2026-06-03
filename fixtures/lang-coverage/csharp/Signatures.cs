// Coverage fixture for the typed signature layer.
// Exercises all five mandated scenarios.

public class Widget
{
    public string Label { get; set; }   // primitive property -> no has_field edge
    public Widget Inner { get; set; }    // non-primitive property -> has_field edge
    public int Count;                    // primitive field -> no has_field edge
    public Widget Owner;                 // non-primitive field -> has_field edge
}

public class Svc
{
    // Requirement 2: method inside a class with parameters
    public Widget Process(Widget input)
    {
        return input;
    }
}

// Requirement 1: static method acting as free-function equivalent, non-primitive
// param + non-primitive return, also carries a primitive param (requirement 4).
public static class Factory
{
    public static Widget Build(Widget w, int n)
    {
        return w;
    }

    // Requirement 5: primitive-first ordering -> non-primitive param must assert index >= 1
    public static Widget Order(int n, Widget w)
    {
        return w;
    }

    // Generic inner types: container suppressed (List), inner Widget gets the edge;
    // Pair is a user generic so it AND its two inner args (Foo, Bar) all get edges,
    // all sharing the param index. Payload `ty` keeps the full textual type.
    public static void Collect(List<Widget> items, Pair<Foo, Bar> pair)
    {
    }

    // Primitive (string) and container (Dictionary) inside generic args must both
    // be suppressed; only the inner Widget gets an edge.
    public static void Lookup(Dictionary<string, Widget> map)
    {
    }
}
