package cryptobench.ciphers.feistel;

import cryptobench.core.Cipher;
import cryptobench.util.Bytes;
import cryptobench.util.Hex;

public class FeistelCipher implements Cipher {
    private final FeistelNetwork network;

    public FeistelCipher(FeistelKey key) {
        this.network = new FeistelNetwork(key);
    }

    @Override
    public String name() { return "feistel"; }

    @Override
    public String encrypt(String plaintext) {
        byte[] data = Bytes.pad(Bytes.of(plaintext), 8);
        for (int off = 0; off < data.length; off += 8) network.block(data, off, false);
        return Hex.encode(data);
    }

    @Override
    public String decrypt(String ciphertext) {
        byte[] data = Hex.decode(ciphertext);
        for (int off = 0; off < data.length; off += 8) network.block(data, off, true);
        return Bytes.toText(data).trim();
    }
}
