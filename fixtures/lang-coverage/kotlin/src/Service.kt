// feature: class, imports (single, alias, star), cross-file call, external call
package com.example

import java.util.LinkedHashMap
import java.util.Collections as Col
import kotlin.math.*

class Service(private val name: String) : Greeter {
    private val cache = LinkedHashMap<String, String>()

    override fun hi(): String {
        return "hello from " + name
    }

    fun run() {
        val greeting = formatName(name)
        println(greeting)
        Col.emptyMap<String, String>()
    }
}
