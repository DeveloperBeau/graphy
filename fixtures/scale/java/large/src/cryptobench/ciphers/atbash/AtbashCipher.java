package cryptobench.ciphers.atbash;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Mirrors the alphabet: A maps to Z, B to Y, and so on. */
public class AtbashCipher implements Cipher {
    public AtbashCipher(AtbashKey key) {
        // Atbash is keyless; the key type exists so the suite wiring is uniform.
    }

    @Override
    public String name() {
        return "atbash";
    }

    @Override
    public String encrypt(String plaintext) {
        return mirror(plaintext);
    }

    @Override
    public String decrypt(String ciphertext) {
        return mirror(ciphertext);
    }

    private String mirror(String text) {
        StringBuilder sb = new StringBuilder();
        for (char c : Alphabet.clean(text).toCharArray()) {
            sb.append(Alphabet.charAt(Alphabet.SIZE - 1 - Alphabet.indexOf(c)));
        }
        return sb.toString();
    }
}
