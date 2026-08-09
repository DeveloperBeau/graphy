package cryptobench.util

object Alphabet {
    const val SIZE = 26

    fun isUpper(c: Char): Boolean = c in 'A'..'Z'

    fun indexOf(c: Char): Int = c - 'A'

    fun charAt(index: Int): Char = 'A' + Math.floorMod(index, SIZE)

    fun clean(text: String): String =
        text.uppercase().filter { isUpper(it) }
}
