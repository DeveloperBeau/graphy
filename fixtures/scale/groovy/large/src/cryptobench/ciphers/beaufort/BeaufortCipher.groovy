package cryptobench.ciphers.beaufort

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Reciprocal variant: ciphertext is key letter minus plaintext letter. */
class BeaufortCipher implements Cipher {
    private final BeaufortKey key

    BeaufortCipher(BeaufortKey key) {
        this.key = key
    }

    String name() {
        return "beaufort"
    }

    String encrypt(String plaintext) {
        return transform(Alphabet.clean(plaintext), true)
    }

    String decrypt(String ciphertext) {
        return transform(Alphabet.clean(ciphertext), false)
    }

    private String transform(String text, boolean forward) {
        StringBuilder sb = new StringBuilder()
        for (int i = 0; i < text.length(); i++) {
            int x = Alphabet.indexOf(text.charAt(i))
            int k = Alphabet.indexOf(key.keyCharAt(i))
            sb.append(Alphabet.charAt(forward ? k - x : k - x))
        }
        return sb.toString()
    }
}
