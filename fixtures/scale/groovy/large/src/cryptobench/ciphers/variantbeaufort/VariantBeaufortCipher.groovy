package cryptobench.ciphers.variantbeaufort

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Subtracts the keyword letter on encrypt, adds it back on decrypt. */
class VariantBeaufortCipher implements Cipher {
    private final VariantBeaufortKey key

    VariantBeaufortCipher(VariantBeaufortKey key) {
        this.key = key
    }

    String name() {
        return "variantbeaufort"
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
            sb.append(Alphabet.charAt(forward ? x - k : x + k))
        }
        return sb.toString()
    }
}
