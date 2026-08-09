package cryptobench.ciphers.hill

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** 2x2 matrix cipher over pairs of letters mod 26. */
class HillCipher implements Cipher {
    private final HillKey key

    HillCipher(HillKey key) {
        this.key = key
    }

    String name() {
        return "hill"
    }

    String encrypt(String plaintext) {
        return apply(Alphabet.clean(plaintext), key.matrix())
    }

    String decrypt(String ciphertext) {
        return apply(Alphabet.clean(ciphertext), key.inverseMatrix())
    }

    private String apply(String input, int[] m) {
        String text = input.length() % 2 == 0 ? input : input + "X"
        StringBuilder sb = new StringBuilder()
        for (int i = 0; i + 1 < text.length(); i += 2) {
            int x = Alphabet.indexOf(text.charAt(i))
            int y = Alphabet.indexOf(text.charAt(i + 1))
            sb.append(Alphabet.charAt(m[0] * x + m[1] * y))
            sb.append(Alphabet.charAt(m[2] * x + m[3] * y))
        }
        return sb.toString()
    }
}
