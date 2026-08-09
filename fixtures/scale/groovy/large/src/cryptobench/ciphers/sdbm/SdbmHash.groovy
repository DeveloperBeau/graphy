package cryptobench.ciphers.sdbm

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** sdbm hash as used by the old sdbm database library. */
class SdbmHash implements HashFunction {
    String name() {
        return "sdbm"
    }

    long digest(String input) {
        long state = 0
        Bytes.of(input).each { b ->
            state = (b & 0xFF) + (state << 6) + (state << 16) - state
        }
        return state
    }
}
