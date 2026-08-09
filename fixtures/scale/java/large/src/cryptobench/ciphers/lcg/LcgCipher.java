package cryptobench.ciphers.lcg;

import cryptobench.core.Cipher;
import cryptobench.util.Bytes;
import cryptobench.util.Hex;

/** Keystream from a linear congruential generator seeded by the key. */
public class LcgCipher implements Cipher {
    private final LcgKey key;

    public LcgCipher(LcgKey key) {
        this.key = key;
    }

    @Override
    public String name() {
        return "lcg";
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
            state = state * 6364136223846793005L + 1442695040888963407L;
            out[i] = (byte) (data[i] ^ (state >>> 16));
        }
        return out;
    }
}
