package cryptobench.ciphers.fnv1a;

import cryptobench.core.HashFunction;
import cryptobench.util.Bytes;

/** FNV-1a 64-bit: xor the byte, multiply by the prime. */
public class Fnv1aHash implements HashFunction {
    @Override
    public String name() {
        return "fnv1a";
    }

    @Override
    public long digest(String input) {
        long state = 0xCBF29CE484222325L;
        for (byte b : Bytes.of(input)) {
            state ^= (b & 0xFF);
            state *= 0x100000001B3L;
        }
        return state;
    }
}
