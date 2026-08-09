package cryptobench.ciphers.affine

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Maps x to (a*x + b) mod 26; a must be coprime with 26. */
class AffineCipher implements Cipher {
    private final AffineKey key

    AffineCipher(AffineKey key) {
        this.key = key
    }

    String name() {
        return "affine"
    }

    String encrypt(String plaintext) {
        StringBuilder sb = new StringBuilder()
        Alphabet.clean(plaintext).each { ch ->
            sb.append(Alphabet.charAt(key.a * Alphabet.indexOf(ch as char) + key.b))
        }
        return sb.toString()
    }

    String decrypt(String ciphertext) {
        int inverse = key.inverseOfA()
        StringBuilder sb = new StringBuilder()
        Alphabet.clean(ciphertext).each { ch ->
            sb.append(Alphabet.charAt(inverse * (Alphabet.indexOf(ch as char) - key.b)))
        }
        return sb.toString()
    }
}
