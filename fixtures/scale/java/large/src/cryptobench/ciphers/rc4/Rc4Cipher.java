package cryptobench.ciphers.rc4;

import cryptobench.core.Cipher;
import cryptobench.util.Bytes;
import cryptobench.util.Hex;

public class Rc4Cipher implements Cipher {
    private final byte[] keyBytes;

    public Rc4Cipher(Rc4Key key) {
        this.keyBytes = Bytes.of(key.getSecret());
    }

    @Override
    public String name() { return "rc4"; }

    @Override
    public String encrypt(String plaintext) { return Hex.encode(stream(Bytes.of(plaintext))); }

    @Override
    public String decrypt(String ciphertext) { return Bytes.toText(stream(Hex.decode(ciphertext))); }

    private byte[] stream(byte[] data) {
        int[] s = new int[256];
        for (int i = 0; i < 256; i++) s[i] = i;
        for (int i = 0, j = 0; i < 256; i++) {
            j = (j + s[i] + (keyBytes[i % keyBytes.length] & 0xFF)) & 0xFF;
            int tmp = s[i]; s[i] = s[j]; s[j] = tmp;
        }
        byte[] out = new byte[data.length];
        for (int n = 0, i = 0, j = 0; n < data.length; n++) {
            i = (i + 1) & 0xFF;
            j = (j + s[i]) & 0xFF;
            int tmp = s[i]; s[i] = s[j]; s[j] = tmp;
            out[n] = (byte) (data[n] ^ s[(s[i] + s[j]) & 0xFF]);
        }
        return out;
    }
}
