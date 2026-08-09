package cryptobench.ciphers.bifid

import cryptobench.ciphers.polybius.PolybiusCipher
import cryptobench.ciphers.polybius.PolybiusKey
import cryptobench.core.Cipher

/** Polybius coordinates split into rows, recombined after transposition. */
class BifidCipher implements Cipher {
    private final PolybiusCipher coordinates

    BifidCipher(BifidKey key) {
        this.coordinates = new PolybiusCipher(new PolybiusKey(key.seedWord))
    }

    String name() {
        return "bifid"
    }

    String encrypt(String plaintext) {
        String digits = coordinates.encrypt(plaintext)
        StringBuilder rows = new StringBuilder()
        StringBuilder cols = new StringBuilder()
        for (int i = 0; i + 1 < digits.length(); i += 2) {
            rows.append(digits.charAt(i))
            cols.append(digits.charAt(i + 1))
        }
        return coordinates.decrypt(rows.toString() + cols.toString())
    }

    String decrypt(String ciphertext) {
        String digits = coordinates.encrypt(ciphertext)
        int half = digits.length().intdiv(2)
        StringBuilder sb = new StringBuilder()
        for (int i = 0; i < half; i++) {
            sb.append(digits.charAt(i)).append(digits.charAt(half + i))
        }
        return coordinates.decrypt(sb.toString())
    }
}
