package cryptobench.ciphers.crc32;

import cryptobench.core.HashFunction;
import cryptobench.util.Bytes;

/** Bitwise CRC-32 with the reflected polynomial, no lookup table. */
public class Crc32Hash implements HashFunction {
    @Override
    public String name() {
        return "crc32";
    }

    @Override
    public long digest(String input) {
        long state = 0xFFFFFFFFL;
        for (byte b : Bytes.of(input)) {
            state ^= (b & 0xFF);
            for (int bit = 0; bit < 8; bit++) {
                state = (state >>> 1) ^ (0xEDB88320L & -(state & 1));
            }
        }
        return state ^ 0xFFFFFFFFL;
    }
}
