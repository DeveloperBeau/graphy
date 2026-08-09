package cryptobench.ciphers.speck;

import cryptobench.core.Cipher;
import cryptobench.util.BlockCodec;
import cryptobench.util.Bytes;
import cryptobench.util.Hex;

public class SpeckCipher implements Cipher {
    private final SpeckKey key;

    public SpeckCipher(SpeckKey key) { this.key = key; }

    @Override
    public String name() { return "speck"; }

    @Override
    public String encrypt(String plaintext) {
        byte[] data = Bytes.pad(Bytes.of(plaintext), 8);
        for (int off = 0; off < data.length; off += 8) {
            BlockCodec.write(data, off, SpeckRounds.encryptBlock(BlockCodec.read(data, off), key));
        }
        return Hex.encode(data);
    }

    @Override
    public String decrypt(String ciphertext) {
        byte[] data = Hex.decode(ciphertext);
        for (int off = 0; off < data.length; off += 8) {
            BlockCodec.write(data, off, SpeckRounds.decryptBlock(BlockCodec.read(data, off), key));
        }
        return Bytes.toText(data).trim();
    }
}
