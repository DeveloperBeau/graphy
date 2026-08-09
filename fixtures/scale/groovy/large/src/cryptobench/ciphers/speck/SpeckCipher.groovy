package cryptobench.ciphers.speck

import cryptobench.core.Cipher
import cryptobench.util.BlockCodec
import cryptobench.util.Bytes
import cryptobench.util.Hex

class SpeckCipher implements Cipher {
    private final SpeckKey key

    SpeckCipher(SpeckKey key) {
        this.key = key
    }

    String name() {
        return "speck"
    }

    String encrypt(String plaintext) {
        byte[] data = Bytes.pad(Bytes.of(plaintext), 8)
        for (int off = 0; off < data.length; off += 8) {
            BlockCodec.write(data, off, SpeckRounds.encryptBlock(BlockCodec.read(data, off), key))
        }
        return Hex.encode(data)
    }

    String decrypt(String ciphertext) {
        byte[] data = Hex.decode(ciphertext)
        for (int off = 0; off < data.length; off += 8) {
            BlockCodec.write(data, off, SpeckRounds.decryptBlock(BlockCodec.read(data, off), key))
        }
        return Bytes.toText(data).trim()
    }
}
