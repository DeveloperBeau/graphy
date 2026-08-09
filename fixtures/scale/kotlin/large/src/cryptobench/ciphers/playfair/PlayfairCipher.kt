package cryptobench.ciphers.playfair

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Digraph substitution over a 5x5 keyword square. */
class PlayfairCipher(key: PlayfairKey) : Cipher {
    private val square = key.square()

    override fun name(): String = "playfair"

    override fun encrypt(plaintext: String): String =
        PlayfairRules.transform(square, PlayfairDigraphs.split(Alphabet.clean(plaintext)), 1)

    override fun decrypt(ciphertext: String): String =
        PlayfairRules.transform(square, PlayfairDigraphs.split(Alphabet.clean(ciphertext)), 4)
}
