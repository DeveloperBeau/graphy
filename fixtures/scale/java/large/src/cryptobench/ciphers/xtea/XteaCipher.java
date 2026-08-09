package cryptobench.ciphers.xtea;

import cryptobench.core.Cipher;
import cryptobench.util.BlockCodec;
import cryptobench.util.Bytes;
import cryptobench.util.Hex;

public class XteaCipher implements Cipher {
    private final XteaKey key;

    public XteaCipher(XteaKey key) { this.key = key; }

    @Override
    public String name() { return "xtea"; }

    @Override
    public String encrypt(String plaintext) {
        byte[] data = Bytes.pad(Bytes.of(plaintext), 8);
        for (int off = 0; off < data.length; off += 8) {
            BlockCodec.write(data, off, XteaRounds.encryptBlock(BlockCodec.read(data, off), key));
        }
        return Hex.encode(data);
    }

    @Override
    public String decrypt(String ciphertext) {
        byte[] data = Hex.decode(ciphertext);
        for (int off = 0; off < data.length; off += 8) {
            BlockCodec.write(data, off, XteaRounds.decryptBlock(BlockCodec.read(data, off), key));
        }
        return Bytes.toText(data).trim();
    }
}
