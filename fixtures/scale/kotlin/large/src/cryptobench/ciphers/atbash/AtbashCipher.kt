package cryptobench.ciphers.atbash

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Mirrors the alphabet: A maps to Z, B to Y, and so on. */
class AtbashCipher(@Suppress("UNUSED_PARAMETER") key: AtbashKey) : Cipher {

    override fun name(): String = "atbash"

    override fun encrypt(plaintext: String): String = mirror(plaintext)

    override fun decrypt(ciphertext: String): String = mirror(ciphertext)

    private fun mirror(text: String): String {
        val sb = StringBuilder()
        for (c in Alphabet.clean(text)) {
            sb.append(Alphabet.charAt(Alphabet.SIZE - 1 - Alphabet.indexOf(c)))
        }
        return sb.toString()
    }
}
