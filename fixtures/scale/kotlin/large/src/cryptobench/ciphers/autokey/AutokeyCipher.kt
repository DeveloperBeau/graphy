package cryptobench.ciphers.autokey

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** The key stream is the primer followed by the plaintext itself. */
class AutokeyCipher(private val key: AutokeyKey) : Cipher {

    override fun name(): String = "autokey"

    override fun encrypt(plaintext: String): String {
        val text = Alphabet.clean(plaintext)
        val stream = key.primer + text
        val sb = StringBuilder()
        for (i in text.indices) {
            sb.append(Alphabet.charAt(Alphabet.indexOf(text[i]) + Alphabet.indexOf(stream[i])))
        }
        return sb.toString()
    }

    override fun decrypt(ciphertext: String): String {
        val text = Alphabet.clean(ciphertext)
        val stream = StringBuilder(key.primer)
        val sb = StringBuilder()
        for (i in text.indices) {
            val plain = Alphabet.charAt(Alphabet.indexOf(text[i]) - Alphabet.indexOf(stream[i]))
            sb.append(plain)
            stream.append(plain)
        }
        return sb.toString()
    }
}
