package cryptobench.ciphers.ctr

import cryptobench.ciphers.feistel.FeistelNetwork
import cryptobench.util.BlockCodec

/** Generates the counter keystream and xors it over the data. */
internal object CtrKeystream {
    fun mask(network: FeistelNetwork, nonce: Long, data: ByteArray): ByteArray {
        val out = ByteArray(data.size)
        var off = 0
        while (off < data.size) {
            val counter = ByteArray(8)
            BlockCodec.write(counter, 0, nonce + off / 8)
            network.block(counter, 0, false)
            var i = 0
            while (i < 8 && off + i < data.size) {
                out[off + i] = (data[off + i].toInt() xor counter[i].toInt()).toByte()
                i++
            }
            off += 8
        }
        return out
    }
}
