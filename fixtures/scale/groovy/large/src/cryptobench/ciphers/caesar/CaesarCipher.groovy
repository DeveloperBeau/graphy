package cryptobench.ciphers.caesar

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Classic shift cipher; the key is the fixed shift amount. */
class CaesarCipher implements Cipher {
    private final CaesarKey key

    CaesarCipher(CaesarKey key) {
        this.key = key
    }

    String name() {
        return "caesar"
    }

    String encrypt(String plaintext) {
        return shiftBy(plaintext, key.shift)
    }

    String decrypt(String ciphertext) {
        return shiftBy(ciphertext, -(key.shift))
    }

    private String shiftBy(String text, int amount) {
        StringBuilder sb = new StringBuilder()
        Alphabet.clean(text).each { ch ->
            sb.append(Alphabet.charAt(Alphabet.indexOf(ch as char) + amount))
        }
        return sb.toString()
    }
}
