package cryptobench.ciphers.atbash

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Mirrors the alphabet: A maps to Z, B to Y, and so on. */
class AtbashCipher implements Cipher {
    AtbashCipher(AtbashKey key) {
        // Atbash is keyless; the key type exists so the suite wiring is uniform.
    }

    String name() {
        return "atbash"
    }

    String encrypt(String plaintext) {
        return mirror(plaintext)
    }

    String decrypt(String ciphertext) {
        return mirror(ciphertext)
    }

    private String mirror(String text) {
        StringBuilder sb = new StringBuilder()
        Alphabet.clean(text).each { ch ->
            sb.append(Alphabet.charAt(Alphabet.SIZE - 1 - Alphabet.indexOf(ch as char)))
        }
        return sb.toString()
    }
}
