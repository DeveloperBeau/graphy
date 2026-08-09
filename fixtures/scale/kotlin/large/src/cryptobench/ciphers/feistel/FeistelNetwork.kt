package cryptobench.ciphers.feistel

import cryptobench.util.BlockCodec

/** Balanced 16-round Feistel permutation over 8-byte blocks. */
class FeistelNetwork(private val key: FeistelKey) {

    fun block(data: ByteArray, off: Int, reverse: Boolean) {
        val packed = BlockCodec.read(data, off)
        var left = (packed ushr 32).toInt()
        var right = packed.toInt()
        for (r in 0 until 16) {
            val round = if (reverse) 15 - r else r
            val tmp = right
            right = left xor roundFn(right, key.subKey(round))
            left = tmp
        }
        BlockCodec.write(data, off, (right.toLong() shl 32) or (left.toLong() and 0xFFFFFFFFL))
    }

    private fun roundFn(half: Int, subKey: Int): Int {
        val mixed = Integer.rotateLeft(half xor subKey, 5)
        return mixed * -0x61c88647 + subKey
    }
}
