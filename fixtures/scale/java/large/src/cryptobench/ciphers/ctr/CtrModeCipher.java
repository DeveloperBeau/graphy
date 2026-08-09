package cryptobench.ciphers.ctr;

import cryptobench.ciphers.feistel.FeistelKey;
import cryptobench.ciphers.feistel.FeistelNetwork;
import cryptobench.core.Cipher;
import cryptobench.util.Bytes;
import cryptobench.util.Hex;

/** Counter mode: encrypt a counter stream, xor it with the data. */
public class CtrModeCipher implements Cipher {
    private final FeistelNetwork network;
    private final CtrModeKey key;

    public CtrModeCipher(CtrModeKey key) {
        this.key = key;
        this.network = new FeistelNetwork(new FeistelKey(key.getBlockKey()));
    }

    @Override
    public String name() { return "ctr"; }

    @Override
    public String encrypt(String plaintext) {
        return Hex.encode(CtrKeystream.mask(network, key.getNonce(), Bytes.of(plaintext)));
    }

    @Override
    public String decrypt(String ciphertext) {
        return Bytes.toText(CtrKeystream.mask(network, key.getNonce(), Hex.decode(ciphertext)));
    }
}
