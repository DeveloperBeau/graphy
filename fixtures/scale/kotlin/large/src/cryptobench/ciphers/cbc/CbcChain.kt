package cryptobench.ciphers.cbc

import cryptobench.ciphers.feistel.FeistelNetwork

/** Applies CBC chaining around the Feistel block permutation. */
internal object CbcChain {
    fun encrypt(network: FeistelNetwork, data: ByteArray, chain: ByteArray) {
        var off = 0
        while (off < data.size) {
            for (i in 0 until 8) data[off + i] = (data[off + i].toInt() xor chain[i].toInt()).toByte()
            network.block(data, off, false)
            data.copyInto(chain, 0, off, off + 8)
            off += 8
        }
    }

    fun decrypt(network: FeistelNetwork, data: ByteArray, chain: ByteArray) {
        var off = 0
        while (off < data.size) {
            val next = data.copyOfRange(off, off + 8)
            network.block(data, off, true)
            for (i in 0 until 8) data[off + i] = (data[off + i].toInt() xor chain[i].toInt()).toByte()
            next.copyInto(chain)
            off += 8
        }
    }
}
