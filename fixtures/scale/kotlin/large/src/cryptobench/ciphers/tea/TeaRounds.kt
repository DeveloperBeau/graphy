package cryptobench.ciphers.tea

/** Tiny Encryption Algorithm with the classic 32-cycle schedule. */
internal object TeaRounds {
    fun encryptBlock(block: Long, key: TeaKey): Long {
        var v0 = (block ushr 32).toInt()
        var v1 = block.toInt()
        for (r in 0 until 32) {
            val sum = -0x61c88647 * (r + 1)
            v0 += ((v1 shl 4) + key.k(0)) xor (v1 + sum) xor ((v1 ushr 5) + key.k(1))
            v1 += ((v0 shl 4) + key.k(2)) xor (v0 + sum) xor ((v0 ushr 5) + key.k(3))
        }
        return pack(v0, v1)
    }

    fun decryptBlock(block: Long, key: TeaKey): Long {
        var v0 = (block ushr 32).toInt()
        var v1 = block.toInt()
        for (r in 32 - 1 downTo 0) {
            val sum = -0x61c88647 * (r + 1)
            v1 -= ((v0 shl 4) + key.k(2)) xor (v0 + sum) xor ((v0 ushr 5) + key.k(3))
            v0 -= ((v1 shl 4) + key.k(0)) xor (v1 + sum) xor ((v1 ushr 5) + key.k(1))
        }
        return pack(v0, v1)
    }

    private fun pack(v0: Int, v1: Int): Long =
        (v0.toLong() shl 32) or (v1.toLong() and 0xFFFFFFFFL)
}
