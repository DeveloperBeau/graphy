package cryptobench.ciphers.xtea

/** XTEA: TEA with a corrected key schedule mixing. */
internal object XteaRounds {
    fun encryptBlock(block: Long, key: XteaKey): Long {
        var v0 = (block ushr 32).toInt()
        var v1 = block.toInt()
        for (r in 0 until 32) {
            var sum = -0x61c88647 * r
            v0 += (((v1 shl 4) xor (v1 ushr 5)) + v1) xor (sum + key.k(sum and 3))
            sum += -0x61c88647
            v1 += (((v0 shl 4) xor (v0 ushr 5)) + v0) xor (sum + key.k((sum ushr 11) and 3))
        }
        return pack(v0, v1)
    }

    fun decryptBlock(block: Long, key: XteaKey): Long {
        var v0 = (block ushr 32).toInt()
        var v1 = block.toInt()
        for (r in 32 - 1 downTo 0) {
            var sum = -0x61c88647 * (r + 1)
            v1 -= (((v0 shl 4) xor (v0 ushr 5)) + v0) xor (sum + key.k((sum ushr 11) and 3))
            sum -= -0x61c88647
            v0 -= (((v1 shl 4) xor (v1 ushr 5)) + v1) xor (sum + key.k(sum and 3))
        }
        return pack(v0, v1)
    }

    private fun pack(v0: Int, v1: Int): Long =
        (v0.toLong() shl 32) or (v1.toLong() and 0xFFFFFFFFL)
}
