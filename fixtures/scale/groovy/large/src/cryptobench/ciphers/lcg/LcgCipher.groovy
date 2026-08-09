package cryptobench.ciphers.lcg

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Keystream from a linear congruential generator seeded by the key. */
class LcgCipher implements Cipher {
    private final LcgKey key

    LcgCipher(LcgKey key) {
        this.key = key
    }

    String name() {
        return "lcg"
    }

    String encrypt(String plaintext) {
        return Hex.encode(mask(Bytes.of(plaintext)))
    }

    String decrypt(String ciphertext) {
        return Bytes.toText(mask(Hex.decode(ciphertext)))
    }

    private byte[] mask(byte[] data) {
        long state = key.seed
        byte[] out = new byte[data.length]
        for (int i = 0; i < data.length; i++) {
            state = state * 1103515245 + 12345
            out[i] = (data[i] ^ (state >>> 16)) as byte
        }
        return out
    }
}
