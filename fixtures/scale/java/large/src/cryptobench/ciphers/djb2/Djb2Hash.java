package cryptobench.ciphers.djb2;

import cryptobench.core.HashFunction;
import cryptobench.util.Bytes;

/** Bernstein's hash: state * 33 + byte. */
public class Djb2Hash implements HashFunction {
    @Override
    public String name() {
        return "djb2";
    }

    @Override
    public long digest(String input) {
        long state = 5381L;
        for (byte b : Bytes.of(input)) {
            state = ((state << 5) + state) + (b & 0xFF);
        }
        return state;
    }
}
