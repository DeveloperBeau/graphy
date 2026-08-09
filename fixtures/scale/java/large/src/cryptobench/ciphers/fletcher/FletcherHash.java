package cryptobench.ciphers.fletcher;

import cryptobench.core.HashFunction;
import cryptobench.util.Bytes;

/** Fletcher-16 style checksum widened to fit the interface. */
public class FletcherHash implements HashFunction {
    @Override
    public String name() {
        return "fletcher";
    }

    @Override
    public long digest(String input) {
        long state = 0L;
        for (byte b : Bytes.of(input)) {
            long sum1 = ((state & 0xFFFF) + (b & 0xFF)) % 255;
            long sum2 = ((state >>> 16) + sum1) % 255;
            state = (sum2 << 16) | sum1;
        }
        return state;
    }
}
