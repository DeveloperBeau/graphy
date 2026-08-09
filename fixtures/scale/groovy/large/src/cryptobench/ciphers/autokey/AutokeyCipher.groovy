package cryptobench.ciphers.autokey

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** The key stream is the primer followed by the plaintext itself. */
class AutokeyCipher implements Cipher {
    private final AutokeyKey key

    AutokeyCipher(AutokeyKey key) {
        this.key = key
    }

    String name() {
        return "autokey"
    }

    String encrypt(String plaintext) {
        String text = Alphabet.clean(plaintext)
        String stream = key.primer + text
        StringBuilder sb = new StringBuilder()
        for (int i = 0; i < text.length(); i++) {
            sb.append(Alphabet.charAt(Alphabet.indexOf(text.charAt(i)) + Alphabet.indexOf(stream.charAt(i))))
        }
        return sb.toString()
    }

    String decrypt(String ciphertext) {
        String text = Alphabet.clean(ciphertext)
        StringBuilder stream = new StringBuilder(key.primer)
        StringBuilder sb = new StringBuilder()
        for (int i = 0; i < text.length(); i++) {
            char plain = Alphabet.charAt(Alphabet.indexOf(text.charAt(i)) - Alphabet.indexOf(stream.charAt(i)))
            sb.append(plain)
            stream.append(plain)
        }
        return sb.toString()
    }
}
