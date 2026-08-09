package cryptobench.ciphers.xorshift

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Keystream from a xorshift64 generator seeded by the key. */
class XorShiftCipher implements Cipher {
    private final XorShiftKey key

    XorShiftCipher(XorShiftKey key) {
        this.key = key
    }

    String name() {
        return "xorshift"
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
            state ^= (state << 13); state ^= (state >>> 7); state ^= (state << 17)
            out[i] = (data[i] ^ (state >>> 16)) as byte
        }
        return out
    }
}
