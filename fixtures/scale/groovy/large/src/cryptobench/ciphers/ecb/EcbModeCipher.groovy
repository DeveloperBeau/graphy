package cryptobench.ciphers.ecb

import cryptobench.ciphers.feistel.FeistelCipher
import cryptobench.ciphers.feistel.FeistelKey
import cryptobench.core.Cipher

/** Electronic codebook: each block enciphered independently. */
class EcbModeCipher implements Cipher {
    private final FeistelCipher block

    EcbModeCipher(EcbModeKey key) {
        this.block = new FeistelCipher(new FeistelKey(key.blockKey))
    }

    String name() {
        return "ecb"
    }

    String encrypt(String plaintext) {
        return block.encrypt(plaintext)
    }

    String decrypt(String ciphertext) {
        return block.decrypt(ciphertext)
    }
}
