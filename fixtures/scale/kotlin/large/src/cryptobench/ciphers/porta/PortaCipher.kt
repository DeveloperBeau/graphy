package cryptobench.ciphers.porta

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Reciprocal cipher over half-alphabets selected by the key letter. */
class PortaCipher(private val key: PortaKey) : Cipher {

    override fun name(): String = "porta"

    override fun encrypt(plaintext: String): String = swapHalves(Alphabet.clean(plaintext))

    override fun decrypt(ciphertext: String): String = swapHalves(Alphabet.clean(ciphertext))

    private fun swapHalves(text: String): String {
        val sb = StringBuilder()
        for (i in text.indices) {
            val x = Alphabet.indexOf(text[i])
            val row = Alphabet.indexOf(key.keyCharAt(i)) / 2
            val y = if (x < 13) 13 + Math.floorMod(x + row, 13) else Math.floorMod(x - 13 - row, 13)
            sb.append(Alphabet.charAt(y))
        }
        return sb.toString()
    }
}
