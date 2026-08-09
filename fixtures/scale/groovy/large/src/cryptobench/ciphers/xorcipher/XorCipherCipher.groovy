package cryptobench.ciphers.xorcipher

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Repeating-key XOR; ciphertext is hex so it stays printable. */
class XorCipherCipher implements Cipher {
    private final byte[] keyBytes

    XorCipherCipher(XorCipherKey key) {
        this.keyBytes = Bytes.of(key.phrase)
    }

    String name() {
        return "xorcipher"
    }

    String encrypt(String plaintext) {
        return Hex.encode(mask(Bytes.of(plaintext)))
    }

    String decrypt(String ciphertext) {
        return Bytes.toText(mask(Hex.decode(ciphertext)))
    }

    private byte[] mask(byte[] data) {
        byte[] out = new byte[data.length]
        for (int i = 0; i < data.length; i++) {
            out[i] = (data[i] ^ keyBytes[i % keyBytes.length]) as byte
        }
        return out
    }
}
