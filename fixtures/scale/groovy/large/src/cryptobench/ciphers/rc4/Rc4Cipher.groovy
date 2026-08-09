package cryptobench.ciphers.rc4

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

class Rc4Cipher implements Cipher {
    private final byte[] keyBytes

    Rc4Cipher(Rc4Key key) {
        this.keyBytes = Bytes.of(key.secret)
    }

    String name() {
        return "rc4"
    }

    String encrypt(String plaintext) {
        return Hex.encode(stream(Bytes.of(plaintext)))
    }

    String decrypt(String ciphertext) {
        return Bytes.toText(stream(Hex.decode(ciphertext)))
    }

    private byte[] stream(byte[] data) {
        int[] s = new int[256]
        for (int i = 0; i < 256; i++) s[i] = i
        int j = 0
        for (int i = 0; i < 256; i++) {
            j = (j + s[i] + (keyBytes[i % keyBytes.length] & 0xFF)) & 0xFF
            int tmp = s[i]; s[i] = s[j]; s[j] = tmp
        }
        byte[] out = new byte[data.length]
        int x = 0, y = 0
        for (int n = 0; n < data.length; n++) {
            x = (x + 1) & 0xFF
            y = (y + s[x]) & 0xFF
            int tmp = s[x]; s[x] = s[y]; s[y] = tmp
            out[n] = (data[n] ^ s[(s[x] + s[y]) & 0xFF]) as byte
        }
        return out
    }
}
