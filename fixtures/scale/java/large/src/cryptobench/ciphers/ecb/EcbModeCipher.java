package cryptobench.ciphers.ecb;

import cryptobench.ciphers.feistel.FeistelCipher;
import cryptobench.ciphers.feistel.FeistelKey;
import cryptobench.core.Cipher;

/** Electronic codebook: each block enciphered independently. */
public class EcbModeCipher implements Cipher {
    private final FeistelCipher block;
    private final EcbModeKey key;

    public EcbModeCipher(EcbModeKey key) {
        this.key = key;
        this.block = new FeistelCipher(new FeistelKey(key.getBlockKey()));
    }

    @Override
    public String name() {
        return "ecb";
    }

    @Override
    public String encrypt(String plaintext) {
        return block.encrypt(plaintext);
    }

    @Override
    public String decrypt(String ciphertext) {
        return block.decrypt(ciphertext);
    }
}
