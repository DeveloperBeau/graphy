// feature: class, data class, sealed class, enum class, interface, object
package com.example

interface Greeter {
    fun hi(): String
}

data class State(val name: String, val running: Boolean)

sealed class Result {
    object Success : Result()
    data class Failure(val msg: String) : Result()
}

enum class Color { RED, GREEN, BLUE }

object Config {
    val maxRetries: Int = 3
}
