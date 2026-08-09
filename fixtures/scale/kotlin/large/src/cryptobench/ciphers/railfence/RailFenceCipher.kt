package cryptobench.ciphers.railfence

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Writes the text in a zigzag across rails, then reads rail by rail. */
class RailFenceCipher(key: RailFenceKey) : Cipher {
    private val pattern = RailPattern(key.rails)

    override fun name(): String = "railfence"

    override fun encrypt(plaintext: String): String {
        val text = Alphabet.clean(plaintext)
        val rows = Array(pattern.railCount()) { StringBuilder() }
        for (i in text.indices) {
            rows[pattern.railFor(i)].append(text[i])
        }
        return rows.joinToString("")
    }

    override fun decrypt(ciphertext: String): String {
        val text = Alphabet.clean(ciphertext)
        val out = CharArray(text.length)
        var cursor = 0
        for (r in 0 until pattern.railCount()) {
            for (i in text.indices) {
                if (pattern.railFor(i) == r) out[i] = text[cursor++]
            }
        }
        return String(out)
    }
}
