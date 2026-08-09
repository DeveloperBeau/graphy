package cryptobench.ciphers.polybius

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Encodes each letter as its row/column pair in a 5x5 square (J folds into I). */
class PolybiusCipher implements Cipher {
    private final String square

    PolybiusCipher(PolybiusKey key) {
        this.square = key.square()
    }

    String name() {
        return "polybius"
    }

    String encrypt(String plaintext) {
        StringBuilder sb = new StringBuilder()
        Alphabet.clean(plaintext).replace('J', 'I').each { ch ->
            int at = square.indexOf(ch)
            sb.append((('1' as char) + at.intdiv(5)) as char).append((('1' as char) + at % 5) as char)
        }
        return sb.toString()
    }

    String decrypt(String ciphertext) {
        StringBuilder sb = new StringBuilder()
        for (int i = 0; i + 1 < ciphertext.length(); i += 2) {
            int row = ciphertext.charAt(i) - ('1' as char)
            int col = ciphertext.charAt(i + 1) - ('1' as char)
            sb.append(square.charAt(row * 5 + col))
        }
        return sb.toString()
    }
}
