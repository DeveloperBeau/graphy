package cryptobench.ciphers.fletcher

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Fletcher-16 style checksum widened to fit the interface. */
class FletcherHash implements HashFunction {
    String name() {
        return "fletcher"
    }

    long digest(String input) {
        long state = 0
        Bytes.of(input).each { b ->
            long sum1 = ((state & 0xFFFF) + (b & 0xFF)) % 255
            long sum2 = ((state >>> 16) + sum1) % 255
            state = (sum2 << 16) | sum1
        }
        return state
    }
}
