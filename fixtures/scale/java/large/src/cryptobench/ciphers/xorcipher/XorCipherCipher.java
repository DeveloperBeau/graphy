package cryptobench.ciphers.xorcipher;

import cryptobench.core.Cipher;
import cryptobench.util.Bytes;
import cryptobench.util.Hex;

/** Repeating-key XOR; ciphertext is hex so it stays printable. */
public class XorCipherCipher implements Cipher {
    private final byte[] keyBytes;

    public XorCipherCipher(XorCipherKey key) {
        this.keyBytes = Bytes.of(key.getPhrase());
    }

    @Override
    public String name() {
        return "xorcipher";
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
        byte[] out = new byte[data.length];
        for (int i = 0; i < data.length; i++) {
            out[i] = (byte) (data[i] ^ keyBytes[i % keyBytes.length]);
        }
        return out;
    }
}
