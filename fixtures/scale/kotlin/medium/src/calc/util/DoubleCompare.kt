package calc.util

import kotlin.math.abs
import kotlin.math.max

const val EPSILON = 1e-12

fun nearlyZero(value: Double): Boolean = abs(value) < EPSILON

fun nearlyEqual(a: Double, b: Double): Boolean =
    abs(a - b) < EPSILON * max(1.0, max(abs(a), abs(b)))
