package cryptobench.ciphers.xorshift;

import cryptobench.core.Cipher;
import cryptobench.util.Bytes;
import cryptobench.util.Hex;

/** Keystream from a xorshift64 generator seeded by the key. */
public class XorShiftCipher implements Cipher {
    private final XorShiftKey key;

    public XorShiftCipher(XorShiftKey key) {
        this.key = key;
    }

    @Override
    public String name() {
        return "xorshift";
    }

    @Override
    public String encrypt(String plaintext) {
        return Hex.encode(mask(Bytes.of(plaintext)));
    }

    @Override
    public String decrypt(String ciphertext) {
        return Bytes.toText(mask(Hex.decode(ciphertext)));
    }

    private byte[] mask(byte[] data) {
        long state = key.getSeed();
        byte[] out = new byte[data.length];
        for (int i = 0; i < data.length; i++) {
            state ^= state << 13; state ^= state >>> 7; state ^= state << 17;
            out[i] = (byte) (data[i] ^ (state >>> 16));
        }
        return out;
    }
}
