package cryptobench.ciphers.ctr

import cryptobench.ciphers.feistel.FeistelKey
import cryptobench.ciphers.feistel.FeistelNetwork
import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Counter mode: encrypt a counter stream, xor it with the data. */
class CtrModeCipher implements Cipher {
    private final FeistelNetwork network
    private final CtrModeKey key

    CtrModeCipher(CtrModeKey key) {
        this.key = key
        this.network = new FeistelNetwork(new FeistelKey(key.blockKey))
    }

    String name() {
        return "ctr"
    }

    String encrypt(String plaintext) {
        return Hex.encode(CtrKeystream.mask(network, key.nonce(), Bytes.of(plaintext)))
    }

    String decrypt(String ciphertext) {
        return Bytes.toText(CtrKeystream.mask(network, key.nonce(), Hex.decode(ciphertext)))
    }
}
