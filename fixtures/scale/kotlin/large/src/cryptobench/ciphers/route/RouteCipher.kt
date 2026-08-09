package cryptobench.ciphers.route

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Writes rows left to right, reads them back boustrophedon (snake order). */
class RouteCipher(key: RouteKey) : Cipher {
    private val width = key.width

    override fun name(): String = "route"

    override fun encrypt(plaintext: String): String {
        val padded = StringBuilder(Alphabet.clean(plaintext))
        while (padded.length % width != 0) padded.append('X')
        return snake(padded.toString())
    }

    override fun decrypt(ciphertext: String): String = snake(Alphabet.clean(ciphertext))

    /** Reversing alternate rows is its own inverse, so both directions share it. */
    private fun snake(text: String): String {
        val sb = StringBuilder()
        var row = 0
        while (row * width < text.length) {
            val slice = text.substring(row * width, minOf(row * width + width, text.length))
            sb.append(if (row % 2 == 0) slice else slice.reversed())
            row++
        }
        return sb.toString()
    }
}
