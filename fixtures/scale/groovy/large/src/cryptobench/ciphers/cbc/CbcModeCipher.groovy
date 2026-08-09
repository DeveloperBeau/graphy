package cryptobench.ciphers.cbc

import cryptobench.ciphers.feistel.FeistelKey
import cryptobench.ciphers.feistel.FeistelNetwork
import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Cipher block chaining over the Feistel block, with a fixed IV from the key. */
class CbcModeCipher implements Cipher {
    private final FeistelNetwork network
    private final CbcModeKey key

    CbcModeCipher(CbcModeKey key) {
        this.key = key
        this.network = new FeistelNetwork(new FeistelKey(key.blockKey))
    }

    String name() {
        return "cbc"
    }

    String encrypt(String plaintext) {
        byte[] data = Bytes.pad(Bytes.of(plaintext), 8)
        CbcChain.encrypt(network, data, key.iv())
        return Hex.encode(data)
    }

    String decrypt(String ciphertext) {
        byte[] data = Hex.decode(ciphertext)
        CbcChain.decrypt(network, data, key.iv())
        return Bytes.toText(data).trim()
    }
}
