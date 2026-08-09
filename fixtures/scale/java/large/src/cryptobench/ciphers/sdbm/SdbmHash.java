package cryptobench.ciphers.sdbm;

import cryptobench.core.HashFunction;
import cryptobench.util.Bytes;

/** sdbm hash as used by the old sdbm database library. */
public class SdbmHash implements HashFunction {
    @Override
    public String name() {
        return "sdbm";
    }

    @Override
    public long digest(String input) {
        long state = 0L;
        for (byte b : Bytes.of(input)) {
            state = (b & 0xFF) + (state << 6) + (state << 16) - state;
        }
        return state;
    }
}
