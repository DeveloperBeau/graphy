package cryptobench.ciphers.keywordsub

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Monoalphabetic substitution built from a keyword-mixed alphabet. */
class KeywordSubCipher(key: KeywordSubKey) : Cipher {
    private val mixed = key.mixedAlphabet()

    override fun name(): String = "keywordsub"

    override fun encrypt(plaintext: String): String {
        val sb = StringBuilder()
        for (c in Alphabet.clean(plaintext)) {
            sb.append(mixed[Alphabet.indexOf(c)])
        }
        return sb.toString()
    }

    override fun decrypt(ciphertext: String): String {
        val sb = StringBuilder()
        for (c in Alphabet.clean(ciphertext)) {
            sb.append(Alphabet.charAt(mixed.indexOf(c)))
        }
        return sb.toString()
    }
}
