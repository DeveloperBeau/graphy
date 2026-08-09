package cryptobench.ciphers.tea;

import cryptobench.core.Cipher;
import cryptobench.util.BlockCodec;
import cryptobench.util.Bytes;
import cryptobench.util.Hex;

public class TeaCipher implements Cipher {
    private final TeaKey key;

    public TeaCipher(TeaKey key) { this.key = key; }

    @Override
    public String name() { return "tea"; }

    @Override
    public String encrypt(String plaintext) {
        byte[] data = Bytes.pad(Bytes.of(plaintext), 8);
        for (int off = 0; off < data.length; off += 8) {
            BlockCodec.write(data, off, TeaRounds.encryptBlock(BlockCodec.read(data, off), key));
        }
        return Hex.encode(data);
    }

    @Override
    public String decrypt(String ciphertext) {
        byte[] data = Hex.decode(ciphertext);
        for (int off = 0; off < data.length; off += 8) {
            BlockCodec.write(data, off, TeaRounds.decryptBlock(BlockCodec.read(data, off), key));
        }
        return Bytes.toText(data).trim();
    }
}
