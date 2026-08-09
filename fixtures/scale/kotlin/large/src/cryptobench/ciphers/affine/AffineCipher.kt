package cryptobench.ciphers.affine

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Maps x to (a*x + b) mod 26; a must be coprime with 26. */
class AffineCipher(private val key: AffineKey) : Cipher {

    override fun name(): String = "affine"

    override fun encrypt(plaintext: String): String {
        val sb = StringBuilder()
        for (c in Alphabet.clean(plaintext)) {
            sb.append(Alphabet.charAt(key.a * Alphabet.indexOf(c) + key.b))
        }
        return sb.toString()
    }

    override fun decrypt(ciphertext: String): String {
        val inverse = key.inverseOfA()
        val sb = StringBuilder()
        for (c in Alphabet.clean(ciphertext)) {
            sb.append(Alphabet.charAt(inverse * (Alphabet.indexOf(c) - key.b)))
        }
        return sb.toString()
    }
}
