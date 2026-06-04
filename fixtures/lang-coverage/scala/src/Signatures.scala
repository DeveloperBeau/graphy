// feature: typed signature layer
package com.example

class Widget(val label: String, val inner: Widget)

class Svc(val widget: Widget, val count: Int) {
  def process(n: Int, w: Widget): Widget = w
}

def build(w: Widget, n: Int): Widget = w

def order(n: Int, w: Widget): Widget = w

class Foo

class Bar

class Pair[A, B]

def collect(items: List[Widget]): Widget = items.head

def pairUp(p: Pair[Foo, Bar]): Widget = ???
