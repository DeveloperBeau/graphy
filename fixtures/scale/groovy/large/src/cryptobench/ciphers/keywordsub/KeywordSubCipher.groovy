package cryptobench.ciphers.keywordsub

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Monoalphabetic substitution built from a keyword-mixed alphabet. */
class KeywordSubCipher implements Cipher {
    private final String mixed

    KeywordSubCipher(KeywordSubKey key) {
        this.mixed = key.mixedAlphabet()
    }

    String name() {
        return "keywordsub"
    }

    String encrypt(String plaintext) {
        StringBuilder sb = new StringBuilder()
        Alphabet.clean(plaintext).each { ch ->
            sb.append(mixed.charAt(Alphabet.indexOf(ch as char)))
        }
        return sb.toString()
    }

    String decrypt(String ciphertext) {
        StringBuilder sb = new StringBuilder()
        Alphabet.clean(ciphertext).each { ch ->
            sb.append(Alphabet.charAt(mixed.indexOf(ch as String)))
        }
        return sb.toString()
    }
}
